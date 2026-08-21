import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/auth/data/model/auth_request.dart';
import 'package:shefaa/features/auth/domain/repository/auth_repository.dart';


class SignInEmailAndPasswordUseCase {
  final AuthRepository _repository;
  const SignInEmailAndPasswordUseCase(this._repository);
  Future<Either<AppException, String>> call(AuthRequest request) {
    return _repository.login(request);
  }
}
