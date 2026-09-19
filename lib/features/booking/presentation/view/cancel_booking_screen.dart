import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_radio.dart';
import 'package:shefaa/core/components/app_scafffold.dart';
import 'package:shefaa/core/components/app_states.dart';
import 'package:shefaa/core/components/app_text.dart';
import 'package:shefaa/core/components/app_text_field.dart';
import 'package:shefaa/core/components/base_bloc_consumer.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/components/section_header.dart';
import 'package:shefaa/core/enum/cancel_reason_type.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/overlays.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/presentation/controller/cancel_booking_cubit.dart';
import 'package:shefaa/features/medical/doctor/presentation/view/widgets/doctor_preview_card.dart';
import 'package:shefaa/shared/presentation/view/result_screen.dart';

class CancelBookingScreen extends StatefulWidget {
  final BookingEntity booking;

  const CancelBookingScreen({super.key, required this.booking});

  @override
  State<CancelBookingScreen> createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  final _cancelType = ValueNotifier<CancelReasonType?>(null);
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: const AppText("إلغاء الحجز")),
      body: SingleChildScrollView(
        child: BaseBlocConsumer<CancelBookingCubit, BookingEntity>(
          onLoading: context.loaderOverlay.show,
          onLoaded: (s){
            context.loaderOverlay.hide();
            if (s.isFailure) {
              _showResult(
                type: ResultType.error404,
                message: s.error?.message,
              );
            }
            if (s.isSuccess) {
              _showResult(
                type: ResultType.visitScheduled,
                message: "تم إلغاء الحجز مع د. ${s.data?.doctor.name ?? ""} بنجاح",
              );
            }
          },
          builder: (s) => Column(
            children: [
              Gap.medium(),
              DoctorPreviewCard(doctor: widget.booking.doctor),
              const SectionHeader(title: "سبب الإلغاء"),
              ValueListenableBuilder(
                valueListenable: _cancelType,
                builder: (_, value, _) => AppRadio<CancelReasonType>(
                  value: value,
                  gapBetweenItems: 0,
                  items: CancelReasonType.values,
                  itemLabelBuilder: (e) => e.text,
                  onChange: (v) => _cancelType.value = v,
                ),
              ),
              Gap.medium(),
              const SectionHeader(title: "معلومات إضافية"),
              AppTextField(
                hintText: "معلومات إضافية",
                controller: _controller,
                maxLines: 4,
                maxLength: 1000,
              ),

              Gap.medium(),
              ValueListenableBuilder(
                valueListenable: _cancelType,
                builder: (_, value, _) {
                  final disabled = value == null;

                  return Column(
                    spacing: UISizes.sp4,
                    children: [
                      AppButton.filled(
                        "إلغاء الحجز",
                        onTap: onCancel,
                        isDisabled: disabled,
                      ),
                      if (disabled)
                        AppIconText(
                          text: "يجب اختيار سبب الإلغاء",
                          icon: AppIcons.error,
                          iconSize: UISizes.sp16,
                          textStyle: context.textTheme.titleSmall,
                          color: context.colors.error,
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
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

  Future<void> onCancel() async {
    final confirm = await context.showWarningBottomSheet(
      title: "تأكيد إلغاء حجز رقم ${widget.booking.id}",
      message:
      "هل أنت متأكد أنك تريد إلغاء حجزك مع د. ${widget.booking.doctor.name} "
          "يوم ${widget.booking.time.toDayAndMonthName(locale: "AR")}؟",
    );

    if (confirm && mounted) {
      context.read<CancelBookingCubit>().cancelBooking(
        widget.booking.id,
        reason: _cancelType.value ?? CancelReasonType.other,
        extraInfo: _controller.text.trim(),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _cancelType.dispose();
    super.dispose();
  }
}