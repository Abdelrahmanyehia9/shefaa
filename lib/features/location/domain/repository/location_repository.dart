import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/location/data/models/location.dart';
import 'package:shefaa/features/location/domain/entity/user_location_entity.dart';

abstract interface class LocationRepository {

  Future<Either<AppException, UserLocationEntity>> addLocation(Location location) ;
  Future<Either<AppException, List<UserLocationEntity>>> getAllLocations() ;
  Future<Either<AppException, UserLocationEntity>>selectLocation({required int locId}) ;
  Future<Either<AppException, Unit>>deleteALocation({required int locId}) ;



}