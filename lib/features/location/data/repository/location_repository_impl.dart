import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/extensions/app_exception.dart';
import 'package:shefaa/core/helper/cache_manger.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/location/data/datasource/location_local_data_source.dart';
import 'package:shefaa/features/location/data/datasource/location_remote_data_source.dart';
import 'package:shefaa/features/location/data/models/location.dart';
import 'package:shefaa/features/location/data/models/user_location.dart';
import 'package:shefaa/features/location/domain/entity/user_location_entity.dart';
import 'package:shefaa/features/location/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;
  final LocationLocalDataSource localDataSource;

  const LocationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<AppException, UserLocationEntity>> addLocation(
    Location location,
  ) async {
    try {
      final response = await remoteDataSource.addLocation(location);
      return right(response.toEntity());
    } catch (e) {
      return left(e.toAppException());
    }
  }

  @override
  Future<Either<AppException, List<UserLocationEntity>>> getAllLocations() async {
    try {
      final locations = await CacheManger.instance
          .cacheFirst<List<UserLocation>>(
            getLocal: localDataSource.getLocations,
            getRemote: remoteDataSource.getAllLocations,
            saveLocal: localDataSource.saveLocations,
            onError: (_) => [],
            cacheMiss: (e) => e == null,
          );
      return right(locations.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(e.toAppException());
    }
  }


  @override
  Future<Either<AppException, UserLocationEntity>> selectLocation({required int locId}) async{
    try{
      final result  = await remoteDataSource.selectLocation(locId: locId) ;
      return right(result.toEntity()) ;

    }catch(e){
      return left(e.toAppException()) ;
    }
  }

  @override
  Future<Either<AppException, Unit>> deleteALocation({required int locId}) async{
   try{
     await remoteDataSource.deleteALocation(locId) ;
     return right(unit) ;
   }catch(e){
     return left(e.toAppException()) ;
   }
  }
}
