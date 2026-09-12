import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/core/services/supabase_service.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor_availability.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor_details.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor_request.dart';

class DoctorRemoteDataSource {
  final SupabaseService _supabaseService;

  const DoctorRemoteDataSource(this._supabaseService);

  Future<PaginationData<Doctor>> getDoctors(DoctorRequest request) async {
    final doctors = await _supabaseService.GET_PAGINATED<Doctor>(
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
      filter: (q) {
        var query = q;

        if (request.specialityId != null) {
          query = query.eq("speciality_id", request.specialityId!);
        }

        if (request.clinicId != null) {
          query = query.eq("clinic_id", request.clinicId!);
        }

        if (request.query != null && request.query!.trim().isNotEmpty) {
          query = query.ilike("name", "%${request.query!.trim()}%");
        }

        return query;
      },
      mapper: Doctor.fromJson,
      page: request.page,
    );
    return doctors;
  }
  Future<List<DoctorAvailability>> getDoctorUpcomingSchedule(int doctorId) async {
    final response = await _supabaseService.RPC(
      function: 'get_doctor_upcoming_schedule',
      params: {"p_doctor_id": doctorId},
    );
    final slots = (response as List)
        .map((e) => DoctorAvailability.fromJson(
      e as Map<String, dynamic>,
    ))
        .toList();

    return slots;
  }
  Future<DoctorDetails> getXDoctor(int id) async {
    final doctor = await _supabaseService.RPC(
      function: "get_doctor_by_id",
      params: {"doctor_id": id},
    );
    return DoctorDetails.fromJson(doctor);
  }
}
