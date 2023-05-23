import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_template/common/common.dart';
import 'package:get_template/widgets/not_found_view.dart';

import '../pages/dashboard/binding.dart';
import '../pages/dashboard/view.dart';
import '../pages/home/binding.dart';
import '../pages/home/view.dart';
import '../pages/login/binding.dart';
import '../pages/login/view.dart';
import '../pages/mine/binding.dart';
import '../pages/mine/view.dart';
import '../pages/splash/binding.dart';
import '../pages/splash/view.dart';

part 'app_routes.dart';

class AppPages {
  static const splash = AppRoutes.splash;

  /// 不需要登录即可访问的路由
  static List<String> noNeedLoginList = [];

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.mine,
      page: () => const MinePage(),
      binding: MineBinding(),
    ),
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.notFound,
    page: () => const NotFoundPage(),
  );

  /// 路由拦截
  static void handleOnGenerateRoute(RouteSettings settings) {
    LogUtil.d(settings.name);
  }
}
