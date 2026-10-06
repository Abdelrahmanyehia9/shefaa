import 'dart:async';
import 'package:shefaa/core/services/auth_service.dart';
import 'package:shefaa/core/services/supabase_service.dart';
import 'package:shefaa/shared/data/models/user_model.dart';

class UserSessionRemoteDataSource {
  final AuthService _authService;
  final SupabaseService _databaseService;
  const UserSessionRemoteDataSource(this._authService, this._databaseService);

  Future<UserModel> getUserFromRemote(String id) async {
    final user = await _databaseService.GET_SINGLE<UserModel>(
      table: "users",
      select: "*, user_location:userlocation(*)",
      filter: (e) => e
          .eq("id", id),

      mapper: UserModel.fromJson,
    );

    return user;
  }

  void setupAuthListeners({
    required void Function(String id) onSignedIn,
    required void Function() onSignedOut,
    required void Function(String id) onUserUpdated,
    void Function(bool isAuth, String? id)? onInitialSession,
    void Function()? onTokenRefreshed,
    void Function()? onPasswordRecovery,
  }) {
    _authService.setupAuthListener(
      onSignedIn: onSignedIn,
      onSignedOut: onSignedOut,
      onUserUpdated: onUserUpdated,
      onInitialSession: () => onInitialSession?.call(
        _authService.isAuthenticated,
        _authService.uID,
      ),
      onPasswordRecovery: onPasswordRecovery,
      onTokenRefreshed: onTokenRefreshed,
    );
  }

  Future<UserModel> updateUser(UserModel user) async {
    final response = await _authService.updateUser(data: user.toJson());
    return UserModel.fromJson(response.user?.userMetadata??{});
  }

  Future<void> signOut() => _authService.signOut();
}
