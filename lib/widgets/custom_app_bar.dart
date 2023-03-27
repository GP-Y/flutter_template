import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// @fileName: comment_app_bar
/// @date: 2023/2/9 10:10
/// @author clover
/// @description: 自定义appbar

class CustomAppBar extends AppBar {
  CustomAppBar({
    Widget? title,
    bool? centerTitle,
    Function? onTap,
    List<Widget>? actions,
    bool? showBack,
  }) : super(
          title: title,
          // backgroundColor: Colors.white,
          centerTitle: centerTitle ?? true,
          actions: actions ?? [],
          leading: showBack ?? true
              ? IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => onTap?.call() ?? Get.back(),
                )
              : SizedBox.shrink(),
        );
}
