import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @fileName: themes
/// @date: 2023/2/9 01:29
/// @author clover
/// @description: 主题

final themeLight = ThemeData.light().copyWith(
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue,
    elevation: 0.5,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 16.sp),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.brown),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
  ),
  textTheme: TextTheme(
    caption: TextStyle(color: Colors.grey, fontSize: 14.sp),
  ),
  tabBarTheme: TabBarTheme(),
);

final themeDark = ThemeData.dark().copyWith(
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.black54,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0.5,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 16.sp),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.brown),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
  ),
  textTheme: TextTheme(
    caption: TextStyle(color: Colors.white, fontSize: 14.sp),
  ),
  tabBarTheme: TabBarTheme(),
);

