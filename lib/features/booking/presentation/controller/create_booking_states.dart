import 'package:shefaa/core/enum/payment_method.dart';
import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';

sealed class CreateBookingStates {
  const CreateBookingStates();
}

class CreateBookingStateInitial extends CreateBookingStates {
  final int currentStep;
  final bool isSelfBooking;
  final PaymentMethod payMethod;

  const CreateBookingStateInitial({
    this.currentStep = 0,
    this.isSelfBooking = true,
    required this.payMethod,
  });

  CreateBookingStateInitial copyWith({
    int? currentStep,
    bool? isSelfBooking,
    PaymentMethod? payMethod,
  }) => CreateBookingStateInitial(
    payMethod: payMethod ?? this.payMethod,
    currentStep: currentStep ?? this.currentStep,
    isSelfBooking: isSelfBooking ?? this.isSelfBooking,
  );
}

class CreateBookingStateLoading extends CreateBookingStates {}

class CreateBookingStateFailure extends CreateBookingStates {
  final AppException exception;
  const CreateBookingStateFailure({required this.exception});
}

class CreateBookingStateSuccess extends CreateBookingStates {
  final BookingEntity bookInfo;
  const CreateBookingStateSuccess(this.bookInfo);
}
