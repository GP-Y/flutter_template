import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// @fileName: localizations
/// @date: 2023/4/5 20:59
/// @author clover
/// @description: 本地化

class AppLocalizations {
  AppLocalizations._();

  //获取当前语言
  static Locale? get locale => Get.deviceLocale;

  //切换语言
  static void changeLanguage(Locale locale) {
    Get.updateLocale(locale);
  }

  static String get login => "login".tr; //登录
  static String get register => "register".tr; //注册
  static String get forgetPassword => "forgetPassword".tr; //忘记密码
  static String get inputTips => "inputTips".tr; //手机号
  static String get account => "account".tr; //账号
  static String get password => "password".tr; //密码
  static String get logOut => "logOut".tr; //退出登录
  static String get skip => "skip".tr; //跳过
  static String get debugger => "debugger".tr; //调试器
  static String get home => "home".tr; //首页
  static String get mine => "mine".tr; //我的
  static String get shop => "shop".tr; //商城
  static String get darkTheme => "darkTheme".tr; //深色主题
  static String get lightTheme => "lightTheme".tr; //浅色主题
  static String get followSystem => "followSystem".tr; //跟随系统
  static String get chinese => "chinese".tr; //中文
  static String get english => "english".tr; //英文
}
