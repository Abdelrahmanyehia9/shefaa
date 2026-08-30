import 'package:flutter/material.dart';
import 'package:shefaa/shared/domain/repository/user_session_repository.dart';

class GetThemeUseCase {
  final UserSessionRepository _repository;
  GetThemeUseCase(this._repository);

  Future<ThemeMode> call() {
    return _repository.getThemeMode();
  }
}
