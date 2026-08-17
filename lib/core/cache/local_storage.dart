abstract final class LocalStorage {
  Future<void> write(String key, dynamic value);
  Future<dynamic> read(String key, {dynamic defaultValue});
  Future<void> delete(String key);
  Future<void> clear();
  Future<bool> containsKey(String key);
}
