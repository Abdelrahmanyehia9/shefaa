/* import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movies_me_new/core/cache/locale_storage.dart';

class SecureLocalStorage implements LocalStorage {
  final FlutterSecureStorage _secureStorage;
  SecureLocalStorage(this._secureStorage);

  static Future<SecureLocalStorage> create() async =>
      SecureLocalStorage(const FlutterSecureStorage());

  @override
  Future<void> clear() async => await _secureStorage.deleteAll();

  @override
  Future<bool> containsKey(String key) async =>
      await _secureStorage.containsKey(key: key);

  @override
  Future<void> delete(String key) {
    return _secureStorage.delete(key: key);
  }

  @override
  Future<dynamic> read(String key, {dynamic defaultValue}) async {
    final value = await _secureStorage.read(key: key);
    if (value == null) return defaultValue;
    try {
      final decoded = jsonDecode(value);
      if (decoded is Map || decoded is List) return decoded;
    } catch (_) {}
    return value;
  }

  @override
  Future<void> write(String key, dynamic value) async {
    switch (value) {
      case Map v:
        await _secureStorage.write(key: key, value: jsonEncode(v));
      case List v:
        await _secureStorage.write(key: key, value: jsonEncode(v));
      default:
        await _secureStorage.write(key: key, value: value.toString());
    }
  }
} */
