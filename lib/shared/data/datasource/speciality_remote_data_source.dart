import 'package:shefaa/core/services/data_base_service.dart';
import 'package:shefaa/shared/data/models/speciality_model.dart';

class SpecialityRemoteDataSource {
  final DatabaseService _databaseService;

  SpecialityRemoteDataSource(this._databaseService);

  Future<List<Speciality>> getSpeciality() async {
    final result = await _databaseService.GET<Speciality>(
      table: "Specialties",
      mapper: Speciality.fromJson,
    );
    return result;
  }
}
