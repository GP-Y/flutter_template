import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储-单例模式
class LocalStorage {
  LocalStorage._();

  static LocalStorage? _instance;

  factory LocalStorage() => _instance ?? LocalStorage._();

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> set(String key, dynamic val) {
    String jsonString = jsonEncode(val);
    return _prefs.setString(key, jsonString);
  }

  dynamic get(String key) {
    String? jsonString = _prefs.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }
}
