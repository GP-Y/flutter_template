import 'package:get_template/common/utils/utils.dart';

/// @fileName: token_kit
/// @date: 2023/2/9 01:29
/// @author clover
/// @description: token管理

class TokenKit {
  static const _tokenKey = "Token";
  static TokenKit? _tokenKit;

  TokenKit._();

  factory TokenKit() {
    _tokenKit ??= TokenKit._();
    return _tokenKit!;
  }

  void saveToken(String? token) {
    LocalStorage().set(_tokenKey, token);
  }

  String? getToken() {
    return LocalStorage().get(_tokenKey);
  }

  void clearToken() {
    LocalStorage().remove(_tokenKey);
  }
}
