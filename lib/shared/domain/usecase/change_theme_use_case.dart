import 'package:flutter/material.dart';
import 'package:shefaa/shared/domain/repository/user_session_repository.dart';

class ChangeThemeUseCase {
  final UserSessionRepository _repository;
  ChangeThemeUseCase(this._repository);

  Future<void> call(ThemeMode mode) {
    return _repository.changeThemeMode(mode);
  }
}
