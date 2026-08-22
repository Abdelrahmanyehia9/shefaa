abstract interface class KeyValueStorage {
  Future<void> write<T>(String key, T value);
  Future<T?> read<T>(String key, {T? defaultValue});
  Future<void> delete(String key);
  Future<void> clear();
  Future<bool> containsKey(String key);
}
