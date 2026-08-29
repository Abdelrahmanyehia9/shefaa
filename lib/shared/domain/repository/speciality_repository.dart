import 'package:shefaa/shared/domain/entity/speciality_entity.dart';

abstract class SpecialityRepository {
  Future<List<SpecialityEntity>>getSpecialities({bool forceRefresh= false});

}