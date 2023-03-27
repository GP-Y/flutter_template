import 'package:flutter/material.dart';
import 'package:get_template/common/common.dart';

/// @fileName: Theme_kit
/// @date: 2023/2/24 16:42
/// @author clover
/// @description:  主题控制器

class ThemeController extends ChangeNotifier {
  ThemeController._();

  static ThemeController? _instance;

  factory ThemeController() => _instance ??= ThemeController._();

  late bool isDarkTheme; //是否是深色主题

  ///获取当前主题
  ThemeMode currentTheme() {
    final String? currentTheme = LocalStorage().get(
      StorageKey.currentTheme,
    );
    if (currentTheme == null) {
      LocalStorage().set(StorageKey.themeFollowSystem, true);
      final Brightness brightness =
          WidgetsBinding.instance.window.platformBrightness;
      isDarkTheme = brightness == Brightness.dark;
      return ThemeMode.system;
    } else {
      if (currentTheme == ThemeMode.dark.toString()) {
        isDarkTheme = true;
        return ThemeMode.dark;
      } else {
        isDarkTheme = false;
        return ThemeMode.light;
      }
    }
  }

  ///设置主题为浅色
  void themeLight() {
    LocalStorage().set(StorageKey.currentTheme, ThemeMode.light.toString());
    LocalStorage().set(StorageKey.themeFollowSystem, false);
    notifyListeners();
  }

  ///设置主题为深色
  void themeDark() {
    LocalStorage().set(StorageKey.currentTheme, ThemeMode.dark.toString());
    LocalStorage().set(StorageKey.themeFollowSystem, false);
    notifyListeners();
  }

  ///设置主题跟随系统
  void themeFollowSystem() {
    LocalStorage().set(StorageKey.themeFollowSystem, true);
    LocalStorage().remove(StorageKey.currentTheme);
    notifyListeners();
  }
}
