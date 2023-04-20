import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// @fileName: base_controller
/// @date: 2023/2/9 10:23
/// @author clover
/// @description: 基础控制器

class BaseController extends GetxController with WidgetsBindingObserver {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }


  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // app进入前台
    } else if (state == AppLifecycleState.inactive) {
      // app处于非活动状态，并且未接收用户输入时调用，比如来了个电话
    } else if (state == AppLifecycleState.paused) {
      // app进入后台
    } else if (state == AppLifecycleState.detached) {
      // app结束时调用
    }
  }
}
