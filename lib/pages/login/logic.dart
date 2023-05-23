import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_template/common/hive/base_info_box.dart';
import 'package:get_template/common/logic/base_controller.dart';
import 'package:get_template/common/utils/utils.dart';
import 'package:get_template/network/api/test_api.dart';

import '../../models/login/login.dart';
import '../../router/app_pages.dart';

class LoginLogic extends BaseController {
  TextEditingController account = TextEditingController();

  TextEditingController password = TextEditingController();

  bool showPassword = false;

  //是否显示密码
  void isShowPassword() {
    showPassword = !showPassword;
    update();
  }

  //登录
  login() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    if (account.text.isEmpty) {
      Get.snackbar('提示', '请输入帐号');
      return;
    }
    if (password.text.isEmpty) {
      Get.snackbar('提示', '请输入密码');
      return;
    }
    Login? res = await TestApi().login(
      account.text,
      password.text,
    );
    if (res == null) {
      Get.snackbar('提示', '登录失败');
    } else {
      Get.snackbar('提示', '登录成功');
      BaseInfoBox.instance.token = res.access_token;
      // Get.offAndToNamed(AppRoutes.dashboard);
    }
    Get.offAndToNamed(AppRoutes.dashboard);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}
