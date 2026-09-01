import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_details_entity.dart';
import 'package:shefaa/features/doctor/domain/repository/doctor_repository.dart';

class GetXDoctorUseCase {
  final DoctorRepository _repository;
  const GetXDoctorUseCase(this._repository);
  Future<Either<AppException, DoctorDetailsEntity>> call(int doctorId) async {
    return await _repository.getXDoctor(doctorId);
  }
}
