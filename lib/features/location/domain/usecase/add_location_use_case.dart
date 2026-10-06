import 'package:shefaa/core/di/get_it.dart';
import 'package:shefaa/core/errors/error_messages.dart';
import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/location/data/models/user_location.dart';
import 'package:shefaa/features/location/domain/entity/user_location_entity.dart';
import 'package:shefaa/features/location/domain/repository/location_repository.dart';
import 'package:shefaa/shared/data/models/user_model.dart';
import 'package:shefaa/shared/domain/repository/user_session_repository.dart';

class AddLocationUseCase {
  final UserSessionRepository sessionRepository ;
  final LocationRepository locationRepository ;
  const AddLocationUseCase({required this.sessionRepository, required this.locationRepository});

  Future<Either<AppException, UserLocationEntity>> call(UserLocation location) async {
    final currentUser = sessionCubit.currentUser;
    if (currentUser == null) {
      return left(
        const AuthenticateException(message: AuthErrorMessages.userNotFound),
      );
    }
    final result = await locationRepository.addLocation(location) ;
    await sessionRepository.updateProfile(UserModel(id: currentUser.uid,));
    return result ;
  }
}
