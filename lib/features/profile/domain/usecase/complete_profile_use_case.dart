import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/shared/domain/entity/user_entity.dart';
import 'package:shefaa/shared/domain/repository/user_session_repository.dart';

class CompleteProfileUseCase {
  final UserSessionRepository _repository;
  const CompleteProfileUseCase(this._repository);

  Future<Either<AppException, Unit>> call(UserEntity u) {
    return _repository.updateProfile(u);
  }
}
