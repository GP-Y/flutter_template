/// @fileName: storage_key
/// @date: 2023/2/9 01:29
/// @author clover
/// @description: 本地存储key

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
