import 'package:flutter/material.dart';
import 'package:get/get.dart';



class DashboardLogic extends GetxController {
  final tabIndex = 0.obs;

  late PageController pageController;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    pageController.jumpToPage(tabIndex.value);
  }

  @override
  void onInit() {
    super.onInit();
    //创建控制器的实例
    pageController = PageController(
      //用来配置PageView中默认显示的页面 从0开始
      initialPage: 0,
      //为true是保持加载的每个页面的状态
      keepPage: true,
    );
    pageController.addListener(() {
      if (pageController.page == 0.0) {
        tabIndex.value = 0;
      }
      if (pageController.page == 1.0) {
        tabIndex.value = 1;
      }
      if (pageController.page == 2.0) {
        tabIndex.value = 2;
      }
    });
  }
}
