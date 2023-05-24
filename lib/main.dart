import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getx_app/common/common.dart';
import 'package:getx_app/network/client.dart';
import 'package:getx_app/widgets/widgets.dart';

import 'app.dart';
import 'common/hive/getx_hive_box.dart';
import 'common/queue/initialize_queue.dart';
import 'config.dart';

void main() async {
  final queue = InitializeQueue.instance
    ..addTask(Config.instance)
    ..addTask(GetxHiveBox.instance)
    ..addTask(RequestClient.instance);
  await queue.doTask();

  runZonedGuarded<void>(() async {
    BuildErrorWidget.takeOver();
    runApp(const GetXApp());
  }, (Object e, StackTrace s) {
    LogUtil.e("Caught unhandled exception $e, StackTrace $s");
  });
}
