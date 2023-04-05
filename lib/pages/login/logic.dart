import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_template/common/logic/base_controller.dart';
import 'package:get_template/common/utils/utils.dart';

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
    LogUtil.i('account: 帐号信息');
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
