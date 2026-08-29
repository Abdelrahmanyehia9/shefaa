import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/shared/data/models/clinic_request.dart';
import 'package:shefaa/shared/domain/entity/clinic_entity.dart';

abstract class ClinicRepository {
  Future<PaginationData<ClinicEntity>>getClinics(ClinicRequest request, {bool forceRefresh = false});
}