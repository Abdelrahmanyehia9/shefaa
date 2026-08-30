import 'package:flutter/material.dart';
import 'package:shefaa/core/errors/exceptions.dart';
import 'package:shefaa/core/helper/either.dart';
import 'package:shefaa/shared/data/models/user_model.dart';
import 'package:shefaa/shared/domain/entity/user_entity.dart';

abstract class UserSessionRepository {
  Future<void> setupAuthListeners({
    required void Function(UserEntity user) onSignedIn,
    required void Function() onSignedOut,
    required void Function(UserEntity user) onUserUpdated,
    void Function()? onFirstTime,
  });
  Future<void> signOut();
  Future<void> finishIntro();
  Future<Either<AppException, Unit>> updateProfile(UserModel user);
  Future<ThemeMode> getThemeMode();
  Future<void> changeThemeMode(ThemeMode mode);
}
