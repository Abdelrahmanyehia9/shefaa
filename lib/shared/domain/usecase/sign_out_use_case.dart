import 'package:shefaa/shared/domain/repository/user_session_repository.dart';

class SignOutUseCase {
  final UserSessionRepository _repository;
  SignOutUseCase(this._repository);

  Future<void> call() async {
    _repository.signOut();
  }
}
