import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/core/services/supabase_service.dart';
import 'package:shefaa/features/doctor/data/models/doctor.dart';
import 'package:shefaa/features/doctor/data/models/doctor_request.dart';

class DoctorRemoteDataSource {
  final SupabaseService _supabaseService;

  const DoctorRemoteDataSource(this._supabaseService);

  Future<PaginationData<Doctor>> getDoctors(DoctorRequest request) async {
    final clinics = await _supabaseService.GET_PAGINATED<Doctor>(
      perPage: request.perPage,
      table: "Doctors",
      select: '''
    id,
    name,
    speciality:Specialties(*),
    image,
    rate,
    doctor_level, 
    clinic:Clinics(
      location:Locations(
      name,
      lat,
      long
      )
    )
  ''',
      mapper: Doctor.fromJson,
      page: request.page,
    );
    return clinics;
  }
}
