import 'package:get/get.dart';

import 'app_en.dart';
import 'app_zh.dart';

/*
https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPInternational/LanguageandLocaleIDs/LanguageandLocaleIDs.html
https://www.ibabbleon.com/iOS-Language-Codes-ISO-639.html
*/

class TranslationUtil extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': app_en,
    'zh_CN': app_zh,
  };
}
