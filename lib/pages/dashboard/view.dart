import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_template/pages/shop/view.dart';

import '../../gen/assets.gen.dart';
import '../../l10n/localizations.dart';
import '../home/view.dart';
import '../mine/view.dart';

import 'logic.dart';

class DashboardPage extends GetView<DashboardLogic> {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        children: const [
          HomePage(),
          ShopPage(),
          MinePage(),
        ],
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Widget _buildNavigationBar() {
    return Obx(
      () => BottomNavigationBar(
        onTap: controller.changeTabIndex,
        currentIndex: controller.tabIndex.value,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            label: AppLocalizations.home,
            icon: Column(children: [
              Assets.images.home.image(
                width: 25.w,
                height: 25.w,
              ),
              Text(
                AppLocalizations.home,
                style: const TextStyle(color: Colors.black),
              ),
            ]),
            activeIcon: Column(children: [
              Assets.images.home.image(
                width: 25.w,
                height: 25.w,
                color: Colors.blueAccent,
              ),
              Text(
                AppLocalizations.home,
                style: const TextStyle(color: Colors.blueAccent),
              ),
            ]),
          ),
          BottomNavigationBarItem(
            label:  AppLocalizations.shop,
            icon: Column(children: [
              Assets.images.shop.image(
                width: 25.w,
                height: 25.w,
              ),
              Text(
                AppLocalizations.shop,
                style: const TextStyle(color: Colors.black),
              ),
            ]),
            activeIcon: Column(children: [
              Assets.images.shop.image(
                width: 25.w,
                height: 25.w,
                color: Colors.blueAccent,
              ),
              Text(
                AppLocalizations.shop,
                style: const TextStyle(color: Colors.blueAccent),
              ),
            ]),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.mine,
            icon: Column(children: [
              Assets.images.mine.image(
                width: 25.w,
                height: 25.w,
              ),
              Text(
                AppLocalizations.mine,
                style: const TextStyle(color: Colors.black),
              ),
            ]),
            activeIcon: Column(children: [
              Assets.images.mine.image(
                width: 25.w,
                height: 25.w,
                color: Colors.blueAccent,
              ),
              Text(
                AppLocalizations.mine,
                style: const TextStyle(color: Colors.blueAccent),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
