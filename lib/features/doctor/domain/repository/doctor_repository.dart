import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/doctor/data/models/doctor_request.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_entity.dart';

abstract class DoctorRepository {
  const DoctorRepository();

  Future<PaginationData<DoctorEntity>> getDoctors(
    DoctorRequest request, {
    bool forceRefresh = false,
  });
}
