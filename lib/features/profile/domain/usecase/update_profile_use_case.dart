import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/shared/data/models/user_model.dart';
import 'package:shefaa/shared/domain/repository/user_session_repository.dart';

class UpdateProfileUseCase {
  final UserSessionRepository _repository;
  const UpdateProfileUseCase(this._repository);

  Future<Either<AppException, Unit>> call(UserModel u) {
    return _repository.updateProfile(u);
  }
}
