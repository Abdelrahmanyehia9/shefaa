import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/enum/payment_method.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/features/booking/data/model/booking_request.dart';
import 'package:shefaa/features/booking/domain/usecase/create_booking_use_case.dart';
import 'package:shefaa/features/booking/presentation/controller/create_booking_states.dart';

class CreateBookingCubit extends Cubit<CreateBookingStates> {
  final CreateBookingUseCase _useCase;

  CreateBookingCubit(this._useCase)
    : _currentStep = 0,
      _isSelfBooking = true,
      _payMethod = PaymentMethod.cash,
      super(const CreateBookingStateInitial(payMethod: PaymentMethod.cash));

  int _currentStep;
  bool _isSelfBooking;
  PaymentMethod _payMethod;

  void nextStep() {
    _updateBookingOptions(currentStep: _currentStep + 1);
  }

  void previousStep() {
    if (_currentStep <= 0) return;
    _updateBookingOptions(currentStep: _currentStep - 1);
  }

  void toggleSelfBooking() {
    _updateBookingOptions(isSelfBooking: !_isSelfBooking);
  }

  void changePaymentMethod(PaymentMethod method) =>
      _updateBookingOptions(payMethod: method);

  Future<void> createBooking({
    required BookingRequest request,
    required num amount,
    num? support,
  }) async {
    safeEmit(CreateBookingStateLoading());

    final result = await _useCase.call(
      request: request,
      paymentStrategy: _payMethod.toStrategy(),
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
    _currentStep = currentStep ?? _currentStep;
    _isSelfBooking = isSelfBooking ?? _isSelfBooking;
    _payMethod = payMethod ?? _payMethod;

    safeEmit(
      CreateBookingStateInitial(
        currentStep: _currentStep,
        isSelfBooking: _isSelfBooking,
        payMethod: _payMethod,
      ),
    );
  }

  bool get isSelfBooking => _isSelfBooking;
  int get currentStep => _currentStep;
  PaymentMethod get paymentMethod => _payMethod;
}
