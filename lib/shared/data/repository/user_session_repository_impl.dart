import 'package:flutter/src/material/app.dart';
import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/extensions/app_exception.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/shared/data/datasource/user_session_local_data_source.dart';
import 'package:shefaa/shared/data/datasource/user_session_remote_data_source.dart';
import 'package:shefaa/shared/data/models/user_model.dart';
import 'package:shefaa/shared/domain/entity/user_entity.dart';
import 'package:shefaa/shared/domain/repository/user_session_repository.dart';

class UserSessionRepositoryImpl implements UserSessionRepository {
  final UserSessionLocalDataSource localDataSource;
  final UserSessionRemoteDataSource remoteDataSource;

  const UserSessionRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<void> finishIntro() => localDataSource.finishIntro();

  @override
  Future<void> setupAuthListeners({
    required void Function(UserEntity user) onSignedIn,
    required void Function() onSignedOut,
    required void Function(UserEntity user) onUserUpdated,
    void Function()? onFirstTime,
  }) async => remoteDataSource.setupAuthListeners(
    onInitialSession: (isAuth, id) async {
      final firstTime = await localDataSource.isFirstTime();
      if (firstTime) {
        onFirstTime?.call();
        return;
      }
      if (isAuth) {
        final user = await _fetchAndSaveToLocal(id!);
        onSignedIn.call(user);
      } else {
        onSignedOut.call();
      }
    },
    onSignedIn: (id) async {
      final user = await _fetchAndSaveToLocal(id);
      onSignedIn.call(user);
    },
    onSignedOut: onSignedOut,
    onUserUpdated: (id) async {
      final user = await _fetchAndSaveToLocal(id);
      onUserUpdated.call(user);
    },
  );

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
    await localDataSource.removeUserFromLocal();
  }

  Future<UserEntity> _fetchAndSaveToLocal(String id) async {
    try {
      final user = await remoteDataSource.getUserFromRemote(id);
      return await localDataSource.saveUserToLocal(user);
    } catch (e) {
      return UserEntity(uid: id);
    }
  }

  @override
  Future<Either<AppException, Unit>> updateProfile(UserModel u) async {
    try {
      await remoteDataSource.updateUser(u);
      return right(unit);
    } catch (e) {
      return left(e.toAppException());
    }
  }

  @override
  Future<void> changeThemeMode(ThemeMode mode) =>
      localDataSource.changeThemeMode(mode);

  @override
  Future<ThemeMode> getThemeMode() => localDataSource.getThemeMode();
}
