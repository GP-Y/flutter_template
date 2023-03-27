import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ShopPage extends GetView<ShopLogic> {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'ShopPage',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
