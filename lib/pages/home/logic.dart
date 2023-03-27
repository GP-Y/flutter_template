import 'package:get_template/common/logic/base_controller.dart';
import 'package:get_template/common/themes/themes.dart';
import 'package:get/get.dart';

class HomeLogic extends BaseController {
  var showLoading = true.obs;

  List imageList = [
    'https://img2.baidu.com/it/u=567357414,4240886412&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500'
  ];

  // 显示loading
  Future startCountdownTimer() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {
      showLoading.value = false;
    });
  }

  //切换主题
  void changeTheme() {
    if (Get.isDarkMode) {
      Get.changeTheme(themeLight);
    } else {
      Get.changeTheme(themeDark);
    }
  }

  @override
  void onReady() {
    startCountdownTimer();
  }

  @override
  void onClose() {}
}
