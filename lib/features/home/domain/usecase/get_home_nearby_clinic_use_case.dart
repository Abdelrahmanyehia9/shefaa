import 'package:shefaa/shared/data/models/clinic_request.dart';
import 'package:shefaa/shared/domain/entity/clinic_entity.dart';
import 'package:shefaa/shared/domain/repository/clinic_repository.dart';

class GetHomeNearbyClinicUseCase {
  final ClinicRepository _repository;
  const GetHomeNearbyClinicUseCase(this._repository);
  Future<List<ClinicEntity>> call([bool forceRefresh = false])async{
    final result   = await _repository.getClinics(
      const ClinicRequest(
          sortBy: ClinicSortBy.nearby,
          perPage: 4,
      ),
      forceRefresh: forceRefresh
    );
    return result.data ;
  }
}
