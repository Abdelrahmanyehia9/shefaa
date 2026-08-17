/* import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:movies_me_new/core/cache/locale_storage.dart';
class HiveLocalStorage implements LocalStorage {
  final String boxName;
  HiveLocalStorage(this.boxName);
  Box get _box => Hive.box(boxName);
  static Future<void> init() async {
    await Hive.initFlutter();
  }

  static Future<void> openBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox(boxName);
    }
  }

  @override
  Future<void> write(String key, dynamic value) async {
    await _box.put(key, value);
  }

  @override
  Future<dynamic> read(String key, {dynamic defaultValue}) async {
    return _box.get(key, defaultValue: defaultValue);
  }

  @override
  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }

  @override
  Future<bool> containsKey(String key) async => _box.containsKey(key);
} */
