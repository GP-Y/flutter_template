import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_app/common/common.dart';

/// @fileName: styles
/// @date: 2023/2/10 14:52
/// @author clover
/// @description: 样式

class AppColors {
  AppColors._();

  static Color get primaryColor =>
      ThemeController().isDarkTheme ? Colors.black : Colors.white;
}

class TextStyles {
  TextStyles._();

  static TextStyle defaultTextStyle = TextStyle(
    fontSize: FontSizes.size14,
    color: Colors.black,
  );

  static TextStyle defaultTitleStyle = TextStyle(
    fontSize: FontSizes.size14,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static TextStyle defaultHintStyle = TextStyle(
    color: Colors.grey,
    fontSize: FontSizes.size14,
  );
}

class ButtonStyles {
  ButtonStyles._();
}

class FontSizes {
  FontSizes._();

  static double size10 = 10.sp;
  static double size11 = 11.sp;
  static double size12 = 12.sp;
  static double size13 = 13.sp;
  static double size14 = 14.sp;
  static double size15 = 15.sp;
  static double size16 = 16.sp;
  static double size17 = 17.sp;
  static double size18 = 18.sp;
  static double size19 = 19.sp;
  static double size20 = 20.sp;
}
