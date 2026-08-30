import 'package:shefaa/core/services/supabase_service.dart';
import 'package:shefaa/shared/data/models/speciality.dart';

class SpecialityRemoteDataSource {
  final SupabaseService _databaseService;

  SpecialityRemoteDataSource(this._databaseService);

  Future<List<Speciality>> getSpeciality() async {
    final result = await _databaseService.GET<Speciality>(
      table: "Specialties",
      filter: (e) => e.order("doctors_count", ascending: false),
      mapper: Speciality.fromJson,
    );
    return result;
  }
}
