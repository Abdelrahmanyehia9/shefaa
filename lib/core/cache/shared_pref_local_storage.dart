/* import 'dart:convert';

import 'package:movies_me_new/core/cache/locale_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefLocalStorage implements LocalStorage {
  final SharedPreferences _prefs;
  SharedPrefLocalStorage(this._prefs);
  static Future<SharedPrefLocalStorage> create() async =>
      SharedPrefLocalStorage(await SharedPreferences.getInstance());
  @override
  Future<void> write(String key, dynamic value) async {
    switch (value) {
      case String v:
        await _prefs.setString(key, v);
      case int v:
        await _prefs.setInt(key, v);
      case bool v:
        await _prefs.setBool(key, v);
      case double v:
        await _prefs.setDouble(key, v);
      case Map v:
        await _prefs.setString(key, jsonEncode(v));
      case List v:
        await _prefs.setString(key, jsonEncode(v));
      default:
        throw UnsupportedError('Type ${value.runtimeType} is not supported');
    }
  }

  @override
  Future<dynamic> read(String key, {dynamic defaultValue}) async {
    final value = _prefs.get(key);
    if (value is String) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is Map || decoded is List) return decoded;
      } catch (_) {}
    }
    return value ?? defaultValue;
  }

  @override
  Future<void> delete(String key) async => _prefs.remove(key);

  @override
  Future<void> clear() async => _prefs.clear();

  @override
  Future<bool> containsKey(String key) async => _prefs.containsKey(key);
} */
