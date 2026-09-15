import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/extensions/app_exception.dart';
import 'package:shefaa/core/helper/cache_manger.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/booking/data/datasource/booking_local_data_source.dart';
import 'package:shefaa/features/booking/data/datasource/booking_remote_data_source.dart';
import 'package:shefaa/features/booking/data/model/booking.dart';
import 'package:shefaa/features/booking/data/model/booking_request.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/domain/repository/booking_repository.dart';
import 'package:shefaa/features/booking/domain/strategy/payment_strategy.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;
  final BookingLocalDataSource localDataSource;

  const BookingRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<AppException, int>> createPayment({
    required PaymentStrategy strategy,
    required num amount,
    num support = 0,
  }) async {
    try {
      final payId = await remoteDataSource.createPayment(
        strategy: strategy,
        amount: amount,
        support: support,
      );
      return right(payId);
    } catch (e) {
      return left(e.toAppException());
    }
  }

  @override
  Future<Either<AppException, int>> createBooking({
    required int payId,
    required BookingRequest request,
  }) async {
    try {
      final bookId = await remoteDataSource.createBooking(
        request: request,
        paymentId: payId,
      );
      return right(bookId);
    } catch (e) {
      return left(e.toAppException());
    }
  }

  @override
  Future<PaginationData<BookingEntity>> getBookings(int page) async {
    final bookings = await CacheManger.instance
        .cacheFirst<PaginationData<Booking>>(
          getLocal: localDataSource.getBookings,
          getRemote: () => remoteDataSource.getAllBooking(page),
          saveLocal: (b) => localDataSource.saveToLocal(b.data),
          cacheMiss: (e) => e == null,
        );
    return PaginationData<BookingEntity>(
      data: bookings.data.map((e) => e.toEntity()).toList(),
      totalCount: bookings.totalCount,
      hasMore: bookings.hasMore,
      currentPage: bookings.currentPage,
      perPage: bookings.perPage,
    );
  }
}
