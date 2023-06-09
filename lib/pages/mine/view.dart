import 'package:flutter/material.dart';
import 'package:getx_app/common/common.dart';
import 'package:getx_app/common/hive/base_info_box.dart';
import 'package:getx_app/router/app_pages.dart';
import 'package:get/get.dart';
import 'package:getx_app/widgets/custom_app_bar.dart';

import '../../l10n/localizations.dart';
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
              child: Text(AppLocalizations.logOut),
              onPressed: () {
                BaseInfoBox.instance.token = null;
                Get.offAllNamed(AppRoutes.login);
              },
            ),
            TextButton(
              child: Text(
                AppLocalizations.debugger,
                style: themeData.textTheme.caption,
              ),
              onPressed: () {
                DebugKit.setup(context);
              },
            ),
            TextButton(
              child: Text(AppLocalizations.darkTheme),
              onPressed: () {
                ThemeController().themeDark();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.lightTheme),
              onPressed: () {
                ThemeController().themeLight();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.followSystem),
              onPressed: () {
                ThemeController().themeFollowSystem();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.chinese),
              onPressed: () {
                AppLocalizations.changeLanguage(const Locale('zh', 'CN'));
              },
            ),
            TextButton(
              child: Text(AppLocalizations.english),
              onPressed: () {
                AppLocalizations.changeLanguage(const Locale('en', 'US'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
