import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/location/domain/entity/user_location_entity.dart';
import 'package:shefaa/features/location/domain/repository/location_repository.dart';

class GetAllLocationsUseCase {
  final LocationRepository _repository;
  const GetAllLocationsUseCase(this._repository);
  Future<Either<AppException, List<UserLocationEntity>>> call()=> _repository.getAllLocations();

}