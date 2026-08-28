import 'package:shefaa/shared/domain/entity/speciality_entity.dart';
import 'package:shefaa/shared/domain/repository/speciality_repository.dart';

class GetSpecialitiesUseCase {
  final SpecialityRepository _repository ;
  const GetSpecialitiesUseCase(this._repository);

  Future<List<SpecialityEntity>>call(){
    return _repository.getSpecialities() ;
  }

}