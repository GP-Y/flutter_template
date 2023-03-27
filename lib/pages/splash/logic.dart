import 'dart:async';
import 'package:get_template/common/logic/base_controller.dart';
import 'package:get_template/router/app_pages.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SplashLogic extends BaseController {
  late RxInt countdownTime = 3.obs;
  late Timer timer;

  void startCountdownTimer() {
    const duration = Duration(seconds: 1);
    timer = Timer.periodic(duration, (timer) {
      if (countdownTime < 2) {
        timer.cancel();
        Get.offAllNamed(AppRoutes.login);
      } else {
        countdownTime = countdownTime - 1;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    startCountdownTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
