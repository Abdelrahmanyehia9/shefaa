import 'package:shefaa/core/models/latlang.dart';
import 'package:shefaa/core/models/pagination_data.dart';
import 'package:shefaa/features/medical/clinic/data/models/clinic_request.dart';
import 'package:shefaa/features/medical/clinic/domain/entity/clinic_entity.dart';
import 'package:shefaa/features/medical/clinic/domain/repository/clinic_repository.dart';

class GetNearbyClinicsUseCase {
  final ClinicRepository _repository;

  GetNearbyClinicsUseCase(this._repository);

  Future<PaginationData<ClinicEntity>> call({
    LatLong? coordinates,
    double? radius ,
    int page = 1,
  }) async {
    final clinics = await _repository.getClinics(
      ClinicRequest(latLong: coordinates, perPage: 5, page: page,
      radius: radius
      ),
    );
    return clinics;
  }
}
