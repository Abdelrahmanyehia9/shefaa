import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/extensions/app_exception.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/booking/domain/entity/booking_entity.dart';
import 'package:shefaa/features/booking/domain/repository/booking_repository.dart';
import 'package:shefaa/features/review/data/models/review_request.dart';
import 'package:shefaa/features/review/domain/repository/review_repository.dart';

class ReviewBookingUseCase {
  final ReviewRepository _repository;
  final BookingRepository _bookingRepository;

  const ReviewBookingUseCase(this._repository, this._bookingRepository);

  Future<Either<AppException, Unit>> call(BookingEntity booking, {ReviewRequest? docReview, ReviewRequest? clinicReview, ReviewRequest? staffReview}) async {
    try {
     if(docReview!=null)await _repository.reviewDoctor(request: docReview, docId: booking.doctor.id) ; 
     if(clinicReview!=null && booking.clinic!=null)await _repository.reviewClinic(request: clinicReview, clinicId: booking.clinic!.id) ; 
     if(staffReview!=null)await _repository.reviewStaff(request: staffReview, docId: booking.doctor.id) ; 
     await _bookingRepository.updateBooking(booking.id,isRated: true ) ;
     return right(unit) ;
      
    } catch (e) {
      return left(e.toAppException());
    }
  }
}
