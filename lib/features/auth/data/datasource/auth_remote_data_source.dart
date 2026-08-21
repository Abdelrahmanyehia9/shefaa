import 'package:shefaa/core/errors/error_messages.dart';
import 'package:shefaa/core/services/auth_service.dart';
import 'package:shefaa/features/auth/data/model/auth_request.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource{
  final AuthService _service ;
  const AuthRemoteDataSource(this._service) ;

  Future<String>login(AuthRequest request)async{
    final response =
    await _service.signInWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
    final user = response.user ;
    if (user == null) {
      throw const AuthException(ErrorMessages.userNotFound);
    }
    return response.user!.id;
  }












}