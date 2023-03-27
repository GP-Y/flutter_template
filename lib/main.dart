import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_template/common/common.dart';
import 'package:get_template/common/global.dart';
import 'package:get_template/router/app_pages.dart';
import 'package:get_template/widgets/widgets.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/generated/l10n.dart';
import 'pages/splash/binding.dart';
import 'pages/splash/view.dart';

void main() {
  runZonedGuarded<void>(() async {
    BuildErrorWidget.takeOver();
    Global.init().then((e) => runApp(const GetXApp()));
  }, (Object e, StackTrace s) {
    LogKit.e("Caught unhandled exception $e, StackTrace $s");
  });
}

class GetXApp extends StatefulWidget {
  const GetXApp({Key? key}) : super(key: key);

  @override
  State<GetXApp> createState() => _GetXAppState();
}

class _GetXAppState extends State<GetXApp> {
  @override
  void initState() {
    super.initState();

    ///监听主题变化
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ThemeController().addListener(() => setState(() {}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      builder: (context, child) => OKToast(
        position: ToastPosition.bottom,
        child: _buildApp(),
      ),
    );
  }

  Widget _buildApp() {
    return GetMaterialApp(
      title: 'getx宇宙',
      theme: themeLight,
      darkTheme: themeDark,
      themeMode: ThemeController().currentTheme(),
      home: const SplashPage(),
      initialBinding: SplashBinding(),
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialRoute: AppPages.splash,
      getPages: AppPages.routes,
      unknownRoute: AppPages.unknownRoute,
      localizationsDelegates: const [
        S.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      locale: Get.deviceLocale,
      supportedLocales: const [
        Locale("zh"),
        Locale("en"),
      ],
    );
  }
}
