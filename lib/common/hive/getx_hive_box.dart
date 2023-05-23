import 'package:get_template/common/hive/base_info_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../queue/initialize_queue.dart';

/// @fileName: getx_hive_box
/// @date: 2023/4/21 00:19
/// @author clover
/// @description: hive box的getx封装

class HiveBoxName {
  /// 基础信息盒子，用于存储token、是否新用户、当前语言等
  static const String baseInfoBox = "base_info_box";
}

class GetxHiveBox with InitializeTask {
  static GetxHiveBox instance = GetxHiveBox._();

  GetxHiveBox._();

  Future<void> initHiveBox() async {
    await Hive.initFlutter('hive');
    await Hive.openBox(HiveBoxName.baseInfoBox);
  }

  @override
  Future<void> onTask() async {
    await initHiveBox();
  }
}
