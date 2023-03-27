import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common.dart';
import '../network/interceptor.dart';
import '../network/client.dart';

/// @fileName: global
/// @date: 2023/2/9 01:29
/// @author clover
/// @description: 全局配置文件

class Global {
  Global._();

  ///记录应用是否使用过
  static void deviceAlreadyOpen() {
    final bool? deviceAlreadyOpen =
        LocalStorage().get(StorageKey.deviceAlreadyOpen);
    if (deviceAlreadyOpen == null || !deviceAlreadyOpen) {
      LocalStorage().set(StorageKey.deviceAlreadyOpen, true);
    } else {
      LogKit.i('deviceAlreadyOpen: $deviceAlreadyOpen');
    }
  }

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

    ///初始化网络请求
    await RequestClient().setupWithInterceptors(
      baseUrl: Config.apiUrl,
      interceptors: [AuthInterceptor()],
    );

    ///本地存储初始化
    await LocalStorage.init();

    ///读取设备第一次打开
    deviceAlreadyOpen();
  }
}
