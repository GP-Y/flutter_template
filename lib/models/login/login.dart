import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login.freezed.dart';
part 'login.g.dart';

@freezed
class Login with _$Login {
  const factory Login({
    String? access_token,
    String? role,
    int? expires_in,
  }) = _Login;



  factory Login.fromJson(Map<String, dynamic> json) =>
      _$LoginFromJson(json);
}
