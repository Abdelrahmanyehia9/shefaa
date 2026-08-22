import 'package:shefaa/core/cache/key_value_storage.dart';
import 'package:shefaa/core/cache/storage_keys.dart';
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
}
