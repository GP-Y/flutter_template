import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_app/router/app_pages.dart';
import 'package:get/get.dart';

import '../../l10n/localizations.dart';
import 'logic.dart';

class SplashPage extends GetView<SplashLogic> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Align(
          child: FlutterLogo(size: 60.w),
        ),
        Positioned(
          top: 50.w,
          right: 15.w,
          child: GestureDetector(
            onTap: () {
              controller.timer.cancel();
              Get.offAllNamed(AppRoutes.login);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
                color: const Color(0x60000000),
              ),
              width: 90.w,
              height: 35.w,
              alignment: Alignment.center,
              child: Obx(
                () => Text(
                  '${AppLocalizations.skip} ${controller.countdownTime.value}s',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
