
import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/location/domain/entity/user_location_entity.dart';
import 'package:shefaa/features/location/domain/repository/location_repository.dart';

class SelectLocationUseCase {
  final LocationRepository _repository ;
  const SelectLocationUseCase(this._repository);




  Future<Either<AppException, UserLocationEntity>>call({required int locId})async{
   final result = await _repository.selectLocation(locId: locId,) ;
   return result ;
  }





}