import 'package:shefaa/features/doctor/data/models/doctor_request.dart';
import 'package:shefaa/features/doctor/domain/entity/doctor_entity.dart';
import 'package:shefaa/features/doctor/domain/repository/doctor_repository.dart';

class GetHomeTopRatedDoctorsUseCase {
  final DoctorRepository _repository;

  const GetHomeTopRatedDoctorsUseCase(this._repository);

  Future<List<DoctorEntity>> call([bool forceRefresh = false]) async {
    final doctors = await _repository.getDoctors(
      const DoctorRequest(sortBy: DoctorSortBy.rating, perPage: 3),
      forceRefresh: forceRefresh,
    );
    return doctors.data;
  }
}
