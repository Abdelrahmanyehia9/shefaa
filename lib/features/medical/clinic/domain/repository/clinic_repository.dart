import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/medical/clinic/data/models/clinic_request.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_details_entity.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';

abstract class ClinicRepository {
  Future<PaginationData<ClinicEntity>> getClinics(
    ClinicRequest request, {
    bool forceRefresh = false,
  });
  Future<Either<AppException, ClinicDetailsEntity>> getXClinic(int clinicId);

}
