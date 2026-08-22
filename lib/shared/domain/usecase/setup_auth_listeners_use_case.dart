import 'package:shefaa/shared/domain/entity/user_entity.dart';
import 'package:shefaa/shared/domain/repository/user_session_repository.dart';

class SetupAuthListenersUseCase {
  final UserSessionRepository _repository;
  const SetupAuthListenersUseCase(this._repository);

  Future<void> call({
    required void Function(UserEntity user) onSignedIn,
    required void Function() onSignedOut,
    required void Function(UserEntity user) onUserUpdated,
    void Function()? onFirstTime,
  }) async {
    return _repository.setupAuthListeners(
      onSignedIn: onSignedIn,
      onSignedOut: onSignedOut,
      onFirstTime: onFirstTime,
      onUserUpdated: onUserUpdated,
    );
  }
}
