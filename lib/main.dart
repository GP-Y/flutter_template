import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_template/common/common.dart';
import 'package:get_template/common/global.dart';
import 'package:get_template/widgets/widgets.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded<void>(() async {
    BuildErrorWidget.takeOver();
    Global.init().then((e) => runApp(const GetXApp()));
  }, (Object e, StackTrace s) {
    LogUtil.e("Caught unhandled exception $e, StackTrace $s");
  });
}
