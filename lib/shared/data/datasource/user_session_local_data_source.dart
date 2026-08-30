import 'package:flutter/material.dart';
import 'package:shefaa/core/cache/key_value_storage.dart';
import 'package:shefaa/core/cache/storage_keys.dart';
import 'package:shefaa/core/extensions/enum.dart';
import 'package:shefaa/shared/data/models/user_model.dart';
import 'package:shefaa/shared/domain/entity/user_entity.dart';

class UserSessionLocalDataSource {
  final KeyValueStorage _storage;
  UserSessionLocalDataSource(this._storage);

  Future<UserEntity> saveUserToLocal(UserModel user) async {
    await _storage.write<Map<String, dynamic>>(StorageKeys.user, user.toJson());
    return user.toEntity();
  }

  Future<void> finishIntro() =>
      _storage.write<bool>(StorageKeys.isFirstTime, false);
  Future<void> removeUserFromLocal() => _storage.delete(StorageKeys.user);
  Future<bool> isFirstTime() async {
    final result = await _storage.read(
      StorageKeys.isFirstTime,
      defaultValue: true,
    );
    return result!;
  }

  Future<ThemeMode> getThemeMode() async {
    final modeStr = await _storage.read(StorageKeys.themeMode);
    final mode = enumFromJson(modeStr, ThemeMode.values);
    return mode ?? ThemeMode.system;
  }

  Future<void> changeThemeMode(ThemeMode mode) async =>
      await _storage.write(StorageKeys.themeMode, mode.name);
}
