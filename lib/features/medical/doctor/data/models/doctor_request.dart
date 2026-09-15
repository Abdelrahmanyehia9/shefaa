import 'package:shefaa/core/enum/sort_by.dart';
import 'package:shefaa/features/medical/shared/data/models/medical_request.dart';

class DoctorRequest extends MedicalRequest {
  final int? clinicId;

  const DoctorRequest({
    super.specialityId,
    super.page,
    super.perPage,
    super.query,
    super.sortBy,
    this.clinicId,
  });

  static const _unset = Object();

  @override
  DoctorRequest copyWith({
    Object? specialityId = _unset,
    int? page,
    int? perPage,
    int? clinicId,
    SortBy? sortBy,
    String? query,
  }) {
    return DoctorRequest(
      specialityId: specialityId == _unset
          ? this.specialityId
          : specialityId as int?,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      clinicId: clinicId ?? this.clinicId,
      sortBy: sortBy ?? this.sortBy,
      query: query ?? this.query,
    );
  }
}
