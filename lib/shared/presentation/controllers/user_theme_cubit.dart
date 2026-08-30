import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/cubit/base_state.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';
import 'package:shefaa/shared/domain/usecase/change_theme_use_case.dart';
import 'package:shefaa/shared/domain/usecase/get_theme_use_case.dart';

class UserThemeCubit extends Cubit<BaseState<ThemeMode>> {
  final GetThemeUseCase getThemeUseCase;

  final ChangeThemeUseCase changeThemeUseCase;
  UserThemeCubit({
    required this.getThemeUseCase,
    required this.changeThemeUseCase,
  }) : super(const .initial());

  Future<void> getThemeMode() async {
    final theme = await getThemeUseCase.call();
    safeEmit(.success(theme));
  }

  Future<void> toggleThemeMode(ThemeMode mode) async {
    await changeThemeUseCase.call(mode);
    safeEmit(.success(mode));
  }
}
