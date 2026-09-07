import 'package:equatable/equatable.dart';
import 'package:shefaa/core/enum/sort_by.dart';


class DoctorRequest extends Equatable {
  final int? specialityId;
  final int page;
  final int perPage;
  final int? clinicId;

  final SortBy? sortBy;

  const DoctorRequest({
    this.specialityId,
    this.page = 1,
    this.perPage = 10,
    this.clinicId,
    this.sortBy,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [specialityId, page, perPage, clinicId, sortBy];

  DoctorRequest copyWith({
    int? specialityId,
    int? page,
    int? perPage,
    int? clinicId,
    SortBy? sortBy,
  }) {
    return DoctorRequest(
      specialityId: specialityId ?? this.specialityId,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      clinicId: clinicId ?? this.clinicId,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}
