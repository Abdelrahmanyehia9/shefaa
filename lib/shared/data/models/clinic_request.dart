import 'package:shefaa/core/models/latlang.dart';

enum ClinicSortBy { nearby, newest, rating }

class ClinicRequest {
  final ClinicSortBy? sortBy;
  final int? specialityId;
  final LatLong? latLong;
  final int page ;
  final int perPage ;

  const ClinicRequest({
    this.sortBy,
    this.latLong,
    this.specialityId,
    this.page =1,
    this.perPage = 10
  });
}
