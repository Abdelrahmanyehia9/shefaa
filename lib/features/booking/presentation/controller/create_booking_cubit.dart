import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/enum/payment_method.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/features/booking/data/model/booking_request.dart';
import 'package:shefaa/features/booking/domain/strategy/payment_strategy.dart';
import 'package:shefaa/features/booking/domain/usecase/create_booking_use_case.dart';
import 'package:shefaa/features/booking/presentation/controller/create_booking_states.dart';

class CreateBookingCubit extends Cubit<CreateBookingStates> {
  final CreateBookingUseCase _useCase;

  CreateBookingCubit(this._useCase)
      : super(
    const CreateBookingStateInitial(
      payMethod: PaymentMethod.cash,
    ),
  );

  CreateBookingStateInitial? get _current =>
      state is CreateBookingStateInitial
          ? state as CreateBookingStateInitial
          : null;

  void nextStep() {
    final current = _current;
    if (current == null) return;

    _updateBookingOptions(
      currentStep: current.currentStep + 1,
    );
  }
  void previousStep() {
    final current = _current;
    if (current == null || current.currentStep <= 0) return;

    _updateBookingOptions(
      currentStep: current.currentStep - 1,
    );
  }

  void toggleSelfBooking() {
    final current = _current;
    if (current == null) return;

    _updateBookingOptions(
      isSelfBooking: !current.isSelfBooking,
    );
  }

  void changePaymentMethod(PaymentMethod method) =>
      _updateBookingOptions(payMethod: method);

  Future<void> createBooking({
    required BookingRequest request,
    required PaymentStrategy payment,
    required num amount,
    num? support,
  }) async {
    safeEmit(CreateBookingStateLoading());

    final result = await _useCase.call(
      request: request,
      paymentStrategy: payment,
      amount: amount,
      support: support,
    );

    result.fold(
          (e) => safeEmit(CreateBookingStateFailure(exception: e)),
          (id) => safeEmit(CreateBookingStateSuccess(id)),
    );
  }

  void _updateBookingOptions({
    int? currentStep,
    bool? isSelfBooking,
    PaymentMethod? payMethod,
  }) {
    final current = _current;
    if (current == null) return;

    safeEmit(
      current.copyWith(
        currentStep: currentStep,
        isSelfBooking: isSelfBooking,
        payMethod: payMethod,
      ),
    );
  }
}