import 'package:flutter/cupertino.dart';

/// @fileName: language_controller
/// @date: 2023/3/9 21:53
/// @author clover
/// @description: 语言控制器

class LanguageController extends ChangeNotifier {
  LanguageController._();

  static LanguageController? _instance;

  factory LanguageController() => _instance ??= LanguageController._();
}
