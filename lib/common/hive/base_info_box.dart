import 'package:hive/hive.dart';
import 'getx_hive_box.dart';

/// @fileName: base_info_box
/// @date: 2023/4/21 00:26
/// @author clover
/// @description: 基础信息盒子

class BaseInfoBox {
  static BaseInfoBox instance = BaseInfoBox._();

  BaseInfoBox._();

  var box = Hive.box(HiveBoxName.baseInfoBox);

  /// token
  String? get token => box.get('token');
  set token(String? value) => box.put('token', value);

  /// 记录应用是否首次打开
  bool? get appIsReady => box.get('isReady');
  set appIsReady(bool? value) => box.put('isReady', value);

  /// 当前语言
  String? get language => box.get('language');
  set language(String? value) => box.put('language', value);

  /// 当前主题
  String? get currentTheme => box.get('currentTheme');
  set currentTheme(String? value) => box.put('currentTheme', value);

  /// 主题是否跟随系统
  bool? get themeFollowSystem => box.get('themeFollowSystem');
  set themeFollowSystem(bool? value) => box.put('themeFollowSystem', value);

  /// 代理ip
  String? get proxyIp => box.get('proxyIp');
  set proxyIp(String? value) => box.put('proxyIp', value);

  /// 代理端口
  int? get proxyPort => box.get('proxyPort');
  set proxyPort(int? value) => box.put('proxyPort', value);
}
