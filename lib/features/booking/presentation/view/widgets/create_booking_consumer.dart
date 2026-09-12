import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/features/booking/presentation/controller/create_booking_cubit.dart';
import 'package:shefaa/features/booking/presentation/controller/create_booking_states.dart';

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

  final void Function(
    BuildContext context,
    CreateBookingCubit cubit,
    int payId,
  )?
  onSuccess;

  final void Function(
    BuildContext context,
    CreateBookingCubit cubit,
    AppException exception,
  )?
  onFailure;
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
    CreateBookingStates state,
  )?
  builder;

  const CreateBookingConsumer({
    super.key,
    this.initBuilder,
    this.successBuilder,
    this.failureBuilder,
    this.builder,
    this.onSuccess,
    this.onInit,
    this.onFailure,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateBookingCubit, CreateBookingStates>(
      listener: (context, state) {
        final cubit = context.read<CreateBookingCubit>();
        switch (state) {
          case CreateBookingStateInitial():
            onInit?.call(context, cubit, state);
          case CreateBookingStateSuccess(:final payId):
            onSuccess?.call(context, cubit, payId);
          case CreateBookingStateFailure(:final exception):
            onFailure?.call(context, cubit, exception);
          default:
            break;
        }
      },
      builder: (context, state) {
        final cubit = context.read<CreateBookingCubit>();

        return switch (state) {
          CreateBookingStateInitial() =>
            initBuilder?.call(context, cubit, state) ??
                builder?.call(context, cubit, state) ??
                const SizedBox(),

          CreateBookingStateSuccess(:final payId) =>
            successBuilder?.call(context, cubit, payId) ??
                builder?.call(context, cubit, state) ??
                const SizedBox(),

          CreateBookingStateFailure(:final exception) =>
            failureBuilder?.call(context, cubit, exception) ??
                builder?.call(context, cubit, state) ??
                const SizedBox(),

          _ => builder?.call(context, cubit, state) ?? const SizedBox(),
        };
      },
    );
  }
}
