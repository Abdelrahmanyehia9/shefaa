import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/extensions/app_exception.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/booking/data/datasource/booking_remote_data_source.dart';
import 'package:shefaa/features/booking/data/model/booking_request.dart';
import 'package:shefaa/features/booking/domain/repository/booking_repository.dart';
import 'package:shefaa/features/booking/domain/strategy/payment_strategy.dart';

class BookingRepositoryImpl implements BookingRepository{
final BookingRemoteDataSource remoteDataSource ;
const BookingRepositoryImpl({required this.remoteDataSource}) ;



  @override
  Future<Either<AppException, int>> createPayment({required PaymentStrategy strategy, required num amount, num support = 0}) async{
    try{
      final payId = await remoteDataSource.createPayment(strategy: strategy, amount: amount, support: support) ;
      return right(payId);
    }catch(e){
      return left(e.toAppException());
    }
  }


  @override
  Future<Either<AppException, int>> createBooking({required int payId, required BookingRequest request}) {
    // TODO: implement createBooking
    throw UnimplementedError();
  }









}