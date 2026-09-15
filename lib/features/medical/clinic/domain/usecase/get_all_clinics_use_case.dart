import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/medical/clinic/data/models/clinic_request.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/clinic/domain/repository/clinic_repository.dart';
import 'package:shefaa/features/medical/shared/data/models/medical_request.dart';

class GetAllClinicsUseCase {
  final ClinicRepository _repository;
  const GetAllClinicsUseCase(this._repository);

  Future<PaginationData<ClinicEntity>> call(
    MedicalRequest request,
    bool forceRefresh,
  ) {
    return _repository.getClinics(
      request as ClinicRequest,
      forceRefresh: forceRefresh,
    );
  }
}
