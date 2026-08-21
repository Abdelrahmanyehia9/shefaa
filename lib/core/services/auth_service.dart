import 'package:supabase_flutter/supabase_flutter.dart';

final class AuthService {
  final SupabaseClient _client ;
  AuthService(this._client);




  Future<AuthResponse>signInWithEmailAndPassword({required String email  ,required String password})async{
    return await _client.auth.signInWithPassword(password: password, email: email ) ;
  }








}