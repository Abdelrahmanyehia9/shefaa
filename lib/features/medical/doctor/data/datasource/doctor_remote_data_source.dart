import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/core/services/supabase_service.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor_details.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor_request.dart';

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
      filter: (e) {
        if (request.specialityId == null) return e;
        return e.eq("speciality_id", request.specialityId!);
      },
      mapper: Doctor.fromJson,
      page: request.page,
    );
    return clinics;
  }

  Future<DoctorDetails> getXDoctor(int id) async {
    final doctor = await _supabaseService.RPC(
      function: "get_doctor_by_id",
      params: {"doctor_id": id},
    );
    return DoctorDetails.fromJson(doctor);
  }
}
