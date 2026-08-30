import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/clinic/data/models/clinic_request.dart';
import 'package:shefaa/features/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/clinic/domain/repository/clinic_repository.dart';

class GetAllClinicsUseCase {
  final ClinicRepository _repository;
  const GetAllClinicsUseCase(this._repository);

  Future<PaginationData<ClinicEntity>> call(
    ClinicRequest request,
    bool forceRefresh,
  ) {
    return _repository.getClinics(request, forceRefresh: forceRefresh);
  }
}
