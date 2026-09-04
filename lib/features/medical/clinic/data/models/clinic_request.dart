import 'package:equatable/equatable.dart';
import 'package:shefaa/core/models/latlang.dart';

enum ClinicSortBy { nearby, newest, rating }

class ClinicRequest extends Equatable {
  final ClinicSortBy? sortBy;
  final int? specialityId;
  final LatLong? latLong;
  final int page;
  final int perPage;

  const ClinicRequest({
    this.sortBy = ClinicSortBy.nearby,
    this.latLong,
    this.specialityId,
    this.page = 1,
    this.perPage = 10,
  });

  ClinicRequest copyWith({
    ClinicSortBy? sortBy,
    int? specialityId,
    LatLong? latLong,
    int? page,
    int? perPage,
  }) => ClinicRequest(
    sortBy: sortBy ?? this.sortBy,
    specialityId: specialityId ?? this.specialityId,
    latLong: latLong ?? this.latLong,
    page: page ?? this.page,
    perPage: perPage ?? this.perPage,
  );

  @override
  List<Object?> get props => [sortBy, specialityId, latLong, page, perPage];
}
