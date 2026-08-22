import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class AuthService {
  final GoTrueClient _client;

  AuthService(this._client);

  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _client.signInWithPassword(password: password, email: email);
  }

  Future<AuthResponse> signUpWithEmailAndPassword({
    required String firstname,
    required String lastName,
    required String email,
    required String password,
  }) async {
    return await _client.signUp(
      data: {"first_name": firstname, "last_name": lastName},
      password: password,
      email: email,
    );
  }

  Future<void> sendForgetPasswordEmail({
    required String email,
    String? redirect,
  }) async => await _client.resetPasswordForEmail(email, redirectTo: redirect);

  User? get user => _client.currentUser;
  bool get isAuthenticated => user != null;
  String? get uID => user?.id;

  StreamSubscription<AuthState> setupAuthListener({
    required void Function(String id) onSignedIn,
    required void Function() onSignedOut,
    required void Function(String id) onUserUpdated,
    void Function()? onInitialSession,
    void Function()? onTokenRefreshed,
    void Function()? onPasswordRecovery,
  }) => _client.onAuthStateChange.listen((data) async {
    final event = data.event;
    final session = data.session;
    switch (event) {
      case AuthChangeEvent.signedIn:
        if (session == null) break;
        onSignedIn.call(session.user.id);
        break;
      case AuthChangeEvent.tokenRefreshed:
        onTokenRefreshed?.call();
        break;
      case AuthChangeEvent.passwordRecovery:
        onPasswordRecovery?.call();
        break;
      case AuthChangeEvent.initialSession:
        onInitialSession?.call();
        break;
      case AuthChangeEvent.signedOut:
        onSignedOut.call();
        break;
      case AuthChangeEvent.userUpdated:
        if (session == null) break;
        onUserUpdated.call(session.user.id);
        break;
      default:
        debugPrint("Unhandled auth event: $event");
    }
  });

  Future<void> signOut() async => await _client.signOut();
  Future<UserResponse> updateUser({
    String? password,
    String? email,
    Object? data,
  }) async {
    return await _client.updateUser(
      UserAttributes(password: password, email: email, data: data),
    );
  }
}
