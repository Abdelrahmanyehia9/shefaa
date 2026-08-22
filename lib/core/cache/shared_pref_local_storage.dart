import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shefaa/core/cache/key_value_storage.dart';

class SharedPrefLocalStorage implements KeyValueStorage {
  final SharedPreferences _prefs;
  SharedPrefLocalStorage(this._prefs);

  static Future<SharedPrefLocalStorage> create() async {
    return SharedPrefLocalStorage(await SharedPreferences.getInstance());
  }

  @override
  Future<void> write<T>(String key, T value) async {
    switch (value) {
      case String v:
        await _prefs.setString(key, v);

      case int v:
        await _prefs.setInt(key, v);

      case bool v:
        await _prefs.setBool(key, v);

      case double v:
        await _prefs.setDouble(key, v);

      case List v:
        await _prefs.setString(key, jsonEncode(v));

      case Map v:
        await _prefs.setString(key, jsonEncode(v));

      default:
        throw UnsupportedError('Type ${value.runtimeType} is not supported');
    }
  }

  @override
  Future<T?> read<T>(String key, {T? defaultValue}) async {
    final value = _prefs.get(key);

    if (value == null) {
      return defaultValue;
    }

    if (T == Map || T == Map<String, dynamic>) {
      return jsonDecode(value as String) as T;
    }

    if (T == List || T == List<dynamic>) {
      return jsonDecode(value as String) as T;
    }

    return value as T;
  }

  @override
  Future<void> delete(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    return _prefs.containsKey(key);
  }
}
