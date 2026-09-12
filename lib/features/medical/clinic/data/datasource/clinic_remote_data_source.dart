import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/core/services/supabase_service.dart';
import 'package:shefaa/features/medical/clinic/data/models/clinic_details.dart';
import 'package:shefaa/features/medical/clinic/data/models/clinic_request.dart';
import 'package:shefaa/features/medical/clinic/data/models/clinic.dart';

class ClinicRemoteDataSource {
  final SupabaseService _supabaseService;

  const ClinicRemoteDataSource(this._supabaseService);

  Future<PaginationData<Clinic>> getClinics(ClinicRequest request) async {
    final clinics = await _supabaseService.GET_PAGINATED<Clinic>(
      perPage: request.perPage,
      table: "Clinics",
      filter: (q) {
        var query = q;

        if (request.specialityId != null) {
          query = query.contains("specialties", [request.specialityId!]);
        }


        if (request.query != null && request.query!.trim().isNotEmpty) {
          query = query.ilike("name", "%${request.query!.trim()}%");
        }

        return query;
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
      page: request.page,
    );
    return clinics;
  }
  Future<ClinicDetails> getXClinic(int id) async {
    final clinic = await _supabaseService.RPC(
      function: "get_clinic_by_id",
      params: {"clinic_id": id},
    );
    return ClinicDetails.fromJson(clinic);
  }

}
