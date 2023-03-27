import 'package:flutter/material.dart';
import 'package:get_template/common/common.dart';
import 'package:get_template/l10n/generated/l10n.dart';
import 'package:get_template/network/token_kit.dart';
import 'package:get_template/router/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_template/widgets/custom_app_bar.dart';

import 'logic.dart';

class MinePage extends GetView<MineLogic> {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(showBack: false),
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text(S.current.logOut),
              onPressed: () {
                TokenKit().clearToken();
                Get.offAllNamed(AppRoutes.login);
              },
            ),
            TextButton(
              child: Text(
                S.current.debugger,
                style: themeData.textTheme.caption,
              ),
              onPressed: () {
                DebugKit.setup(context);
              },
            ),
            TextButton(
              child: Text('深色主题'),
              onPressed: () {
                ThemeController().themeDark();
              },
            ),
            TextButton(
              child: Text('浅色主题'),
              onPressed: () {
                ThemeController().themeLight();
              },
            ),
            TextButton(
              child: Text('跟随系统'),
              onPressed: () {
                ThemeController().themeFollowSystem();
              },
            ),
          ],
        ),
      ),
    );
  }
}
