import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_icon_text.dart';
import 'package:shefaa/core/components/app_states.dart';
import 'package:shefaa/core/components/gap.dart';
import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/extensions/date_time.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/extensions/sizes.dart';
import 'package:shefaa/core/extensions/theme.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
import 'package:shefaa/core/utils/app_icons.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/presentation/controller/create_booking_cubit.dart';
import 'package:shefaa/features/booking/presentation/controller/create_booking_states.dart';
import 'package:shefaa/shared/presentation/view/result_screen.dart';

class CreateBookingConsumer extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    CreateBookingCubit cubit,
    CreateBookingStateInitial state,
  )?
  initBuilder;
  final void Function(
    BuildContext context,
    CreateBookingCubit cubit,
    CreateBookingStateInitial state,
  )?
  onInit;

  final Widget Function(
    BuildContext context,
    CreateBookingCubit cubit,
    BookingEntity booking,
  )?
  successBuilder;

  final Widget Function(
    BuildContext context,
    CreateBookingCubit cubit,
    AppException exception,
  )?
  failureBuilder;

  final Widget Function(
    BuildContext context,
    CreateBookingCubit cubit,
    CreateBookingStateInitial state,
  )?
  builder;

  const CreateBookingConsumer({
    super.key,
    this.initBuilder,
    this.successBuilder,
    this.failureBuilder,
    this.builder,
    this.onInit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateBookingCubit, CreateBookingStates>(
      listener: (context, state) {
        final cubit = context.read<CreateBookingCubit>();
        switch (state) {
          case CreateBookingStateInitial():
            onInit?.call(context, cubit, state);
          case CreateBookingStateLoading():
            context.loaderOverlay.show();
          case CreateBookingStateSuccess(:final bookInfo):
            context.loaderOverlay.hide();
            context.pushReplacementNamed(
              Routes.result,
              arguments: ResultScreenArgs(
                type: ResultType.visitScheduled,
                message:
                    "نود اعلامك بان تم تاكيد الحجز بنجاح رقم الحجز هو ${bookInfo.id} كن فاليعاد ولا تتاخر",
                footer: (context) => Column(
                  spacing: UISizes.h12,
                  children: [
                    _BookingInfoRow(
                      firstIcon: AppIcons.profile,
                      firstLabel: bookInfo.patientName,
                      secondIcon: AppIcons.pay,
                      secondLabel:bookInfo.lastPayment.method.text ,
                    )  ,
                    _BookingInfoRow(
                      firstIcon: AppIcons.calender,
                      firstLabel: bookInfo.time.toDayAndMonthName(locale: "AR"),
                      secondIcon: AppIcons.time,
                      secondLabel:bookInfo.localTime.formatted,
                    ),
                    Gap.medium(),

                    AppButton.filled(
                      "الى الحجوزات",
                      onTap: () => context.pushNamedAndRemoveUntil(
                        Routes.shell,
                        arguments: 2,
                      ),
                    ),
                    AppButton.text(
                      "الرئيسية",
                      onTap: () =>
                          context.pushNamedAndRemoveUntil(Routes.shell),
                      align: Alignment.center,
                    ),

                  ],
                ),
              ),
            );

          case CreateBookingStateFailure(:final exception):
            context.loaderOverlay.hide();
            context.pushNamed(
              Routes.result,
              arguments: ResultScreenArgs(
                message: exception.message,
                type: ResultType.error404,
                footer: (context) => Column(
                  spacing: UISizes.h12,
                  children: [
                    AppButton.filled(
                      "الى الرئيسية",
                      onTap: () =>
                          context.pushNamedAndRemoveUntil(Routes.shell),
                    ),
                    AppButton.text(
                      "الصفحة السابقة",
                      align: Alignment.center,
                      onTap: context.pop,
                    ),
                  ],
                ),
              ),
            );
        }
      },
      builder: (context, state) {
        final cubit = context.read<CreateBookingCubit>();

        return switch (state) {
          CreateBookingStateInitial() =>
            initBuilder?.call(context, cubit, state) ??
                builder?.call(context, cubit, state) ??
                const SizedBox(),

          CreateBookingStateSuccess(bookInfo: final bookInfo) =>
            successBuilder?.call(context, cubit, bookInfo) ??
                builder?.call(
                  context,
                  cubit,
                  CreateBookingStateInitial(
                    payMethod: cubit.paymentMethod,
                    currentStep: cubit.currentStep,
                    isSelfBooking: cubit.isSelfBooking,
                  ),
                ) ??
                const SizedBox(),

          CreateBookingStateFailure(:final exception) =>
            failureBuilder?.call(context, cubit, exception) ??
                builder?.call(
                  context,
                  cubit,
                  CreateBookingStateInitial(
                    payMethod: cubit.paymentMethod,
                    currentStep: cubit.currentStep,
                    isSelfBooking: cubit.isSelfBooking,
                  ),
                ) ??
                const SizedBox(),

          _ =>
            builder?.call(
                  context,
                  cubit,
                  CreateBookingStateInitial(
                    payMethod: cubit.paymentMethod,
                    currentStep: cubit.currentStep,
                    isSelfBooking: cubit.isSelfBooking,
                  ),
                ) ??
                const SizedBox(),
        };
      },
    );
  }
}



class  _BookingInfoRow extends StatelessWidget {
  final String? firstLabel , secondLabel ;
  final IconData? firstIcon , secondIcon  ;
  const  _BookingInfoRow({this.firstLabel, this.secondLabel, this.firstIcon, this.secondIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width *.8,
      child: Row(
        children: [
          Expanded(child: _item(firstLabel, firstIcon, context)),
          Expanded(child: _item(secondLabel, secondIcon, context))
        ],
      ),
    );
  }

  Widget _item(String? label , IconData? icon , BuildContext context) =>AppIconText(
    textStyle: context.textTheme.labelMedium,

    icon: icon,
    iconColor: context.colors.primary,
    text: label
  );
}
