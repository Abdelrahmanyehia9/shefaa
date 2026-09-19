import 'package:shefaa/core/enum/booking_status.dart';
import 'package:shefaa/core/enum/cancel_reason_type.dart';
import 'package:shefaa/core/enum/user_role.dart';
import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/booking/data/model/booking_cancellation.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/domain/repository/booking_repository.dart';

class CancelBookingUseCase {
  final BookingRepository _repository ;
  const CancelBookingUseCase( this._repository);


  Future<Either<AppException, BookingEntity>>call(int id, {required CancelReasonType reason , String? extra})async{
    final request = BookingCancellation(reason: reason, cancelledBy: UserRole.patient, extraInfo: extra)  ;
    return await _repository.updateBooking(id, status: BookingStatus.cancelled, cancellation: request) ;
  }




}