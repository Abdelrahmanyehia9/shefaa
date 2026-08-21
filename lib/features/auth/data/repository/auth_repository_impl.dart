import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/extensions/app_exception.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:shefaa/features/auth/data/model/auth_request.dart';
import 'package:shefaa/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _source  ;
  AuthRepositoryImpl(this._source);

  @override

  Future<Either<AppException, String>> login(
      AuthRequest request,
      ) async
  {
    try {
      final result = await _source.login(request) ;
      return right(result);
    } catch (e) {
      return left(e.toAppException());
    }
  }
}