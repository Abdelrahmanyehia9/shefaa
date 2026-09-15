import 'package:shefaa/core/enum/sort_by.dart';
import 'package:shefaa/core/models/latlang.dart';
import 'package:shefaa/features/medical/shared/data/models/medical_request.dart';

class ClinicRequest extends MedicalRequest {
  final LatLong? latLong;
  const ClinicRequest({
    super.sortBy = SortBy.nearby,
    this.latLong,
    super.specialityId,
    super.page = 1,
    super.query,
    super.perPage = 10,
  });

  @override
  ClinicRequest copyWith({
    SortBy? sortBy,
    int? specialityId,
    LatLong? latLong,
    int? page,
    int? perPage,
    String? query,
  }) => ClinicRequest(
    sortBy: sortBy ?? this.sortBy,
    specialityId: specialityId ?? this.specialityId,
    latLong: latLong ?? this.latLong,
    page: page ?? this.page,
    perPage: perPage ?? this.perPage,
    query: query ?? this.query,
  );
}
