import 'package:shefaa/shared/domain/repository/user_session_repository.dart';

class FinishIntroUseCase {
  final UserSessionRepository _repository;
  const FinishIntroUseCase(this._repository);

  Future<void> call() {
    return _repository.finishIntro();
  }
}
