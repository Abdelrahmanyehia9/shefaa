import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/doctor/data/models/doctor_request.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_details_entity.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_entity.dart';

abstract class DoctorRepository {
  const DoctorRepository();

  Future<PaginationData<DoctorEntity>> getDoctors(
    DoctorRequest request, {
    bool forceRefresh = false,
  });

  Future<Either<AppException, DoctorDetailsEntity>> getXDoctor(int doctorId);
}
