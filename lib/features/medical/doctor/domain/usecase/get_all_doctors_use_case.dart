import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor_request.dart';
import 'package:shefaa/features/medical/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/medical/doctor/domain/repository/doctor_repository.dart';
import 'package:shefaa/features/medical/shared/data/models/medical_request.dart';

class GetAllDoctorsUseCase {
  final DoctorRepository _repository;
  const GetAllDoctorsUseCase(this._repository);

  Future<PaginationData<DoctorEntity>> call(
    MedicalRequest request, {
    bool forceRefresh = false,
  }) {
    return _repository.getDoctors(request as DoctorRequest, forceRefresh: forceRefresh);
  }
}
