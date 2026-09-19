import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_states.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/overlays.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/presentation/controller/booking_schedule_controller.dart';
import 'package:shefaa/features/booking/presentation/controller/booking_validator.dart';
import 'package:shefaa/features/booking/presentation/controller/change_booking_date_cubit.dart';
import 'package:shefaa/features/booking/presentation/view/forms/booking_form_v1.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_doctor_info.dart';
import 'package:shefaa/features/booking/presentation/view/widgets/booking_info_card.dart';
import 'package:shefaa/shared/presentation/view/result_screen.dart';

class RescheduleBookingScreen extends StatefulWidget {
  final BookingEntity booking;
  const RescheduleBookingScreen({super.key, required this.booking});

  @override
  State<RescheduleBookingScreen> createState() => _RescheduleBookingScreenState();
}

class _RescheduleBookingScreenState extends State<RescheduleBookingScreen> {
  late final BookingScheduleController _controller;
  late final BookingValidator _validator;

  @override
  void initState() {
    final time = widget.booking.time ;
    _controller = BookingScheduleController(
      selectedDate: time,
      selectedTime: widget.booking.localTime
    );
    _validator = BookingValidator(schedule: _controller);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const AppText(" تغيير ميعاد الاستشارة"),
      ),
      body: BaseBlocConsumer<ChangeBookingDateCubit, BookingEntity>(
        onLoading: context.loaderOverlay.show,
        onLoaded: (s){
          context.loaderOverlay.hide() ;
          if(s.isSuccess){
            final BookingEntity d = s.data! ;
            _showResult(type: ResultType.success,
            message: "تم تغيير ميعاد الحجز مع دكتور ${d.doctor.name} الى يوم ${d.time.toYearMonthDay(locale: "AR")} الساعة ${d.localTime.formatted}"
            );
          }
          if(s.isFailure){
            _showResult(type: ResultType.error404,
            message: s.error?.message
            );

          }
        },
        builder:(s)=> Column(
          spacing: UISizes.h8,
          children: [
            BookingDoctorInfo(doctor: widget.booking.doctor),
            AnimatedBuilder(
                animation: _controller,
                builder:(_,_)=> BookingInfoCard(
                    localTime: _controller.selectedTime,
                    dateTime: _controller.selectedDate,
                    booking: widget.booking)),
            BookingFormV1(controller: _controller),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: _validator.validationMessage,
              builder: (_, value, _) => Column(
                  spacing: UISizes.h4,
                  children: [
                    AppButton.filled(
                      isDisabled: value != null,
                      "تاكيد",
                      onTap: onChangeBooking
                    ),
                    Visibility(
                      visible: value != null,
                      maintainState: true,
                      maintainAnimation: true,
                      maintainSize: true,
                      child: AppIconText(
                        text: value,
                        icon: AppIcons.error,
                        iconSize: UISizes.sp16,
                        textStyle: context.textTheme.titleSmall,
                        color: context.colors.error,
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }

  void _showResult({
    required ResultType type,
    String? message,
  }) =>
      context.pushNamedAndRemoveUntil
        (
        Routes.result,
        arguments: ResultScreenArgs(
          type: type,
          message: message,
          footer: (context)=>Column(
            spacing: UISizes.sp4,
            children: [
              AppButton.filled(
                "الرئيسية",
                onTap: () => context.pushNamedAndRemoveUntil(Routes.shell),
              ),
              AppButton.text(
                "إلى الحجوزات",
                align: Alignment.center,
                onTap: () => context.pushNamedAndRemoveUntil(
                  Routes.shell,
                  arguments: 2,
                ),
              ),
            ],
          ),
        ),
      );
  Future<void>onChangeBooking()async{
    if(_controller.selectedDate == null || _controller.selectedTime == null )return ;
    final message = "هل انت متاكد من  انك تريد تغيير الميعاد الى يوم ${_controller.selectedDate?.toYearMonthDay(locale: "AR")??""} الساعة ${_controller.selectedTime?.formatted??""}";
    final confirm  = await context.showWarningBottomSheet(title: "تاكيد تغير الميعاد",message: message) ;
    if(confirm && mounted){
      context.read<ChangeBookingDateCubit>().changeDate(widget.booking.id, newDate: _controller.toDateTime());
    }

  }
  @override
  void dispose() {
    _controller.dispose();
    _validator.dispose() ;
    super.dispose();
  }
}
