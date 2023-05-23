import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储key
class StorageKey {
  StorageKey._();

  /// token
  static const String token = 'token';

  /// 设备是否第一次打开
  static const String deviceAlreadyOpen = 'device_already_open';

  /// 当前语言
  static const String language = 'language';

  /// 当前主题
  static const String currentTheme = 'current_theme';

  /// 主题是否跟随系统
  static const String themeFollowSystem = 'theme_follow_system';
}

/// 本地存储-单例模式
class StorageUtil {
  static StorageUtil? _instance;

  StorageUtil._();

  factory StorageUtil() => _instance ?? StorageUtil._();

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
