import 'package:get/get.dart';

import '../home/logic.dart';
import '../mine/logic.dart';
import '../shop/logic.dart';

import 'logic.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardLogic());
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => ShopLogic());
    Get.lazyPut(() => MineLogic());
  }
}
