import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/booking/data/model/booking_request.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/domain/repository/booking_repository.dart';
import 'package:shefaa/features/booking/domain/strategy/payment_strategy.dart';

class CreateBookingUseCase {
  final BookingRepository _repository;

  const CreateBookingUseCase(this._repository);

  Future<Either<AppException, BookingEntity>> call({
    required BookingRequest request,
    required PaymentStrategy paymentStrategy,
    required num amount,
    num? support,
  }) async {
    final paymentResult = await _repository.createPayment(
      strategy: paymentStrategy,
      amount: amount,
      support: support ?? 0,
    );

    return paymentResult.fold(
      left,
      (paymentId) =>
          _repository.createBooking(payId: paymentId, request: request),
    );
  }
}
