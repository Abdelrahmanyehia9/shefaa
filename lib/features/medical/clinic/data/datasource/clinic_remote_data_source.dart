import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/core/services/supabase_service.dart';
import 'package:shefaa/features/medical/clinic/data/models/clinic_details.dart';
import 'package:shefaa/features/medical/clinic/data/models/clinic_request.dart';
import 'package:shefaa/features/medical/clinic/data/models/clinic.dart';

class ClinicRemoteDataSource {
  final SupabaseService _supabaseService;

  const ClinicRemoteDataSource(this._supabaseService);

  Future<PaginationData<Clinic>> getClinics(ClinicRequest request) {
    final ll = request.latLong;
    return _supabaseService.RPC_PAGINATED<Clinic>(
      function: 'get_clinics',
      page: request.page,
      perPage: request.perPage,
      params: {
        'p_speciality_id': request.specialityId,
        'p_query': request.query?.trim(),
        'p_lat': ll?.lat,
        'p_long': ll?.long,
        'p_radius_km': request.radius,
      },
      select: '''
      id,
      name,
      logo,
      rate,
      cover,
      location:Locations(
        name,
        lat,
        long
      )
    ''',
      mapper: Clinic.fromJson,
    );
  }


  Future<ClinicDetails> getXClinic(int id) async {
    final clinic = await _supabaseService.RPC(
      function: "get_clinic_by_id",
      params: {"clinic_id": id},
    );
    return ClinicDetails.fromJson(clinic);
  }
}
