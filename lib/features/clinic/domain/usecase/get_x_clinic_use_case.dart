import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/clinic/domain/entity/clinic_details_entity.dart';
import 'package:shefaa/features/clinic/domain/repository/clinic_repository.dart';

class GetXClinicUseCase {
  final ClinicRepository _clinicRepository;

  const GetXClinicUseCase(this._clinicRepository);

  Future<Either<AppException, ClinicDetailsEntity>> call(int clinicId) =>
      _clinicRepository.getXClinic(clinicId);
}
