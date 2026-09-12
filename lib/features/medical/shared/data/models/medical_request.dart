import 'package:shefaa/core/enum/sort_by.dart';

abstract class MedicalRequest {
  final int? specialityId;
  final int page;
  final int perPage;
  final String? query;
  final SortBy? sortBy;

  const MedicalRequest({
    this.specialityId,
    this.page = 1,
    this.perPage = 10,
    this.query,
    this.sortBy,
  });

  MedicalRequest copyWith({int? specialityId, String? query, int? page});
}
