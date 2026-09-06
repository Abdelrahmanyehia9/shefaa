import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_availability_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/repository/doctor_repository.dart';

class GetDoctorAvailabilityUseCase {
  final DoctorRepository _repository ;
  const GetDoctorAvailabilityUseCase(this._repository) ;



  Future<Either<AppException, List<DoctorAvailabilityEntity>>>call(int doctorId)=>_repository.getDoctorAvailability(doctorId) ;
}