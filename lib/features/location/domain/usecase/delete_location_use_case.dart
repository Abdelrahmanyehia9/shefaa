import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/location/domain/repository/location_repository.dart';

class DeleteLocationUseCase {
  final LocationRepository _repository  ;
 const DeleteLocationUseCase(this._repository);
  Future<Either<AppException, Unit>>call({required int id})async{
    return _repository.deleteALocation(locId: id) ;
  }


}