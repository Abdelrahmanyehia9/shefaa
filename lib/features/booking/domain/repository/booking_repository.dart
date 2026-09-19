import 'package:shefaa/core/enum/booking_status.dart';
import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/booking/data/model/booking_cancellation.dart';
import 'package:shefaa/features/booking/data/model/booking_request.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/domain/strategy/payment_strategy.dart';

abstract interface class BookingRepository {
  Future<Either<AppException, int>> createPayment({
    required PaymentStrategy strategy,
    required num amount,
    num support = 0,
  });
  Future<Either<AppException, BookingEntity>>updateBooking(int id,{BookingStatus? status , DateTime? dateTime,bool? notifyMe, BookingCancellation? cancellation});
  Future<Either<AppException, BookingEntity>> createBooking({
    required int payId,
    required BookingRequest request,
  });
  Future<PaginationData<BookingEntity>> getBookings(int page);
}
