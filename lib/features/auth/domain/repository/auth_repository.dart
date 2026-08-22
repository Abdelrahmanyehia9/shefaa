import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/auth/data/model/auth_request.dart';

abstract class AuthRepository {
  Future<Either<AppException, String>> login(AuthRequest request);
  Future<Either<AppException, String>> signup(AuthRequest request);
}
