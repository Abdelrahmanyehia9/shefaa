import 'package:shefaa/shared/data/models/doctor_request.dart';
import 'package:shefaa/shared/domain/entity/doctor_entity.dart';
import 'package:shefaa/shared/domain/repository/doctor_repository.dart';

class GetHomeTopRatedDoctorsUseCase {
  final DoctorRepository _repository;

  const GetHomeTopRatedDoctorsUseCase(this._repository);

  Future<List<DoctorEntity>> call([bool forceRefresh = false]) async {
    final doctors = await _repository.getDoctors(
      const DoctorRequest(sortBy: DoctorSortBy.rating, perPage: 3),
      forceRefresh: forceRefresh,
    );
    return doctors.data ;
  }
}
