import 'package:shefaa/features/medical/clinic/data/models/clinic_request.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/clinic/domain/repository/clinic_repository.dart';

class GetHomeNearbyClinicUseCase {
  final ClinicRepository _repository;
  const GetHomeNearbyClinicUseCase(this._repository);
  Future<List<ClinicEntity>> call([bool forceRefresh = false]) async {
    final result = await _repository.getClinics(
      const ClinicRequest(perPage: 4),
      forceRefresh: forceRefresh,
    );
    return result.data;
  }
}
