import 'package:flutter/material.dart';
import 'package:getx_app/common/common.dart';

/// @fileName: Theme_kit
/// @date: 2023/2/24 16:42
/// @author clover
/// @description:  主题控制器

class ThemeController extends ChangeNotifier {
  static ThemeController? _instance;

  ThemeController._();

  factory ThemeController() => _instance ??= ThemeController._();

  final Brightness brightness =
      WidgetsBinding.instance.window.platformBrightness;

  late bool isDarkTheme; //是否是深色主题

  ///获取当前主题
  ThemeMode currentTheme() {
    final String? currentTheme = StorageUtil().get(
      StorageKey.currentTheme,
    );
    if (currentTheme == null) {
      StorageUtil().set(StorageKey.themeFollowSystem, true);
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
    StorageUtil().set(StorageKey.currentTheme, ThemeMode.light.toString());
    StorageUtil().set(StorageKey.themeFollowSystem, false);
    notifyListeners();
  }

  ///设置主题为深色
  void themeDark() {
    StorageUtil().set(StorageKey.currentTheme, ThemeMode.dark.toString());
    StorageUtil().set(StorageKey.themeFollowSystem, false);
    notifyListeners();
  }

  ///设置主题跟随系统
  void themeFollowSystem() {
    StorageUtil().set(StorageKey.themeFollowSystem, true);
    StorageUtil().remove(StorageKey.currentTheme);
    notifyListeners();
  }
}
