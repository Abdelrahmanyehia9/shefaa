enum DoctorSortBy { nearby, newest, rating, price }

class DoctorRequest {
  final int? specialityId;
  final int page;
  final int perPage;
  final int? clinicId;

  final DoctorSortBy? sortBy;

  const DoctorRequest({
    this.specialityId,
    this.page = 1,
    this.perPage = 10,
    this.clinicId,
    this.sortBy,
  });
}
