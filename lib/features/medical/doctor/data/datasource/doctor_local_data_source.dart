import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor_details.dart';
import 'package:shefaa/features/medical/doctor/data/models/doctor_request.dart';

class DoctorLocalDataSource {
  Future<PaginationData<Doctor>?> getDoctors(DoctorRequest request) async {
    return null;
  }

  Future<void> saveDoctors(List<Doctor> doctors) async {
    return;
  }

  Future<void> saveXDoctor(DoctorDetails doctor) async {
    return;
  }

  Future<DoctorDetails?> getXDoctor(int id) async {
    return null;
  }
}
