import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/booking/data/model/booking_request.dart';
import 'package:shefaa/features/booking/domain/strategy/payment_strategy.dart';

abstract interface class BookingRepository {
Future<Either<AppException, int>> createPayment({required PaymentStrategy strategy,required num amount , num support = 0 });
Future<Either<AppException, int>> createBooking({required int payId , required BookingRequest request});
}