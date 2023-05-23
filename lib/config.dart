import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common/common.dart';
import 'common/queue/initialize_queue.dart';

/// @fileName: global
/// @date: 2023/2/9 01:29
/// @author clover
/// @description: 全局配置文件

const env = 'DEV'; //PROD

// 开发环境
const devHost = 'https://dev-api.gigitech.cn';

// 生产环境
const prodHost = 'https://preprod-api.gigimed.cn';

class Config with InitializeTask {
  static final Config instance = Config._();

  Config._(); // 私有构造函数

  static const apiUrl = (env == "DEV") ? devHost : prodHost;

  static bool isRelease = const bool.fromEnvironment(
    "dart.vm.product",
  );

  ///初始化应用
  static Future init() async {
    ///运行初始
    WidgetsFlutterBinding.ensureInitialized();

    ///android状态栏为透明的沉浸
    if (Platform.isAndroid) {
      const systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

    ///本地存储初始化
    await StorageUtil.init();

    ///读取设备第一次打开
    await _deviceAlreadyOpen();
  }

  ///记录应用是否使用过
  static Future<void> _deviceAlreadyOpen() async {
    final bool? deviceAlreadyOpen =
        await StorageUtil().get(StorageKey.deviceAlreadyOpen);
    if (deviceAlreadyOpen == null || !deviceAlreadyOpen) {
      await StorageUtil().set(StorageKey.deviceAlreadyOpen, true);
    } else {
      LogUtil.i('deviceAlreadyOpen: $deviceAlreadyOpen');
    }
  }

  @override
  int? get priority => 1000;

  @override
  Future<void> onTask() async {
    await init();
  }
}
