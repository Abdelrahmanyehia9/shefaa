import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/core/services/supabase_service.dart';
import 'package:shefaa/shared/data/models/clinic_request.dart';
import 'package:shefaa/shared/data/models/clinic.dart';

class ClinicRemoteDataSource {
  final SupabaseService _databaseService;

  const ClinicRemoteDataSource(this._databaseService);

  Future<PaginationData<Clinic>> getClinics(ClinicRequest request) async {
    final clinics = await _databaseService.GET_PAGINATED<Clinic>(
      perPage: request.perPage,
      table: "Clinics",
      select: '''
    id,
    name,
    logo,
    rate,
    location:Locations(
      name,
      lat,
      long
    )
  ''',
      mapper: Clinic.fromJson, page: request.page,
    );
    return clinics;
  }
}
