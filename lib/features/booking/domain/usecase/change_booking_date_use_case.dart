import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/domain/repository/booking_repository.dart';

class ChangeBookingDateUseCase {
  final BookingRepository _repository ;
  const ChangeBookingDateUseCase(this._repository);


  Future<Either<AppException , BookingEntity>>call(int bookId, {required DateTime newDate})async{
    return await _repository.updateBooking(bookId,dateTime:newDate);
  }




}