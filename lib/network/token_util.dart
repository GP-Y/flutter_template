import 'package:get_template/common/utils/utils.dart';

/// @fileName: token_kit
/// @date: 2023/2/9 01:29
/// @author clover
/// @description: token管理

class TokenUtil {
  static const _tokenKey = "Token";
  static TokenUtil? _tokenKit;

  TokenUtil._();

  factory TokenUtil() {
    _tokenKit ??= TokenUtil._();
    return _tokenKit!;
  }

  void saveToken(String? token) {
    StorageUtil().set(_tokenKey, token);
  }

  String? getToken() {
    return StorageUtil().get(_tokenKey);
  }

  void clearToken() {
    StorageUtil().remove(_tokenKey);
  }
}
