import 'package:shefaa/features/medical/speciality/domain/entity/speciality_entity.dart';
import 'package:shefaa/features/medical/speciality/domain/repository/speciality_repository.dart';

class GetSpecialitiesUseCase {
  final SpecialityRepository _repository;
  const GetSpecialitiesUseCase(this._repository);

  Future<List<SpecialityEntity>> call({bool forceRefresh = false}) {
    return _repository.getSpecialities(forceRefresh: forceRefresh);
  }
}
