import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_template/common/common.dart';
import 'package:get_template/router/app_pages.dart';
import 'package:oktoast/oktoast.dart';

import 'l10n/translation_impl.dart';
import 'pages/splash/binding.dart';
import 'pages/splash/view.dart';

/// @fileName: app
/// @date: 2023/4/5 21:32
/// @author clover
/// @description: app

class GetXApp extends StatefulWidget {
  const GetXApp({Key? key}) : super(key: key);

  @override
  State<GetXApp> createState() => _GetXAppState();
}

class _GetXAppState extends State<GetXApp> {
  // 本地化代理
  Iterable<LocalizationsDelegate<dynamic>>? delegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  @override
  void initState() {
    super.initState();
    ThemeController().addListener(() => setState(() {}));
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
      translations: TranslationImpl(),
      locale: Get.deviceLocale,
      localizationsDelegates: delegates,
    );
  }
}
