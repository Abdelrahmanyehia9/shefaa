import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/clinic/data/models/clinic_details.dart';
import 'package:shefaa/features/clinic/data/models/clinic_request.dart';
import 'package:shefaa/features/clinic/data/models/clinic.dart';

class ClinicLocalDataSource {
  Future<PaginationData<Clinic>?> getClinics([ClinicRequest? request]) async {
    return null;
  }

  Future<void> saveClinics(List<Clinic> clinics) async {
    return;
  }



  Future<void> saveXClinic(ClinicDetails clinic) async {
    return;
  }

  Future<ClinicDetails?> getXClinic(int id) async {
    return null;
  }
}

