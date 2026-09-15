import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shefaa/core/components/app_button.dart';
import 'package:shefaa/core/components/app_states.dart';
import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/extensions/navigation.dart';
import 'package:shefaa/core/helper/ui_sizes.dart';
import 'package:shefaa/core/routing/routes.dart';
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
    int payId,
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
          case CreateBookingStateSuccess(:final bookId):
            context.loaderOverlay.hide();
            context.pushNamed(
              Routes.result,
              arguments: ResultScreenArgs(
                type: ResultType.scheduled,
                message:
                    "نود اعلامك بان تم تاكيد الحجز بنجاح رقم الحجز هو $bookId كن فاليعاد ولا تتاخر",
                footer: (context) => Column(
                  spacing: UISizes.h12,
                  children: [
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

          CreateBookingStateSuccess(bookId: final payId) =>
            successBuilder?.call(context, cubit, payId) ??
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
