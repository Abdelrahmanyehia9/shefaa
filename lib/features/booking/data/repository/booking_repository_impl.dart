import 'package:shefaa/core/enum/booking_status.dart';
import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/extensions/app_exception.dart';
import 'package:shefaa/core/helper/cache_manger.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/booking/data/datasource/booking_local_data_source.dart';
import 'package:shefaa/features/booking/data/datasource/booking_remote_data_source.dart';
import 'package:shefaa/features/booking/data/model/booking.dart';
import 'package:shefaa/features/booking/data/model/booking_cancellation.dart';
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
  Future<Either<AppException, BookingEntity>> createBooking({
    required int payId,
    required BookingRequest request,
  }) async {
    try {
      final book = await remoteDataSource.createBooking(
        request: request,
        paymentId: payId,
      );
      return right(book.toEntity());
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

  @override
  Future<Either<AppException, BookingEntity>>updateBooking(int id, {BookingStatus? status , DateTime? dateTime,bool? notifyMe , BookingCancellation ? cancellation})async{
    try{
      final updatedBooking =await remoteDataSource.updateBooking(
        id,
        status: status,
        time: dateTime,
        notifyMe: notifyMe,
        cancellation: cancellation
      ) ;
      await localDataSource.updateBooking(booking: updatedBooking) ;
      return right(updatedBooking.toEntity()) ;

    }catch(e){
      return left(e.toAppException());
    }
  }


}
