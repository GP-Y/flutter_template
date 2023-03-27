// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Login _$$_LoginFromJson(Map<String, dynamic> json) => _$_Login(
      access_token: json['access_token'] as String?,
      role: json['role'] as String?,
      expires_in: json['expires_in'] as int?,
    );

Map<String, dynamic> _$$_LoginToJson(_$_Login instance) => <String, dynamic>{
      'access_token': instance.access_token,
      'role': instance.role,
      'expires_in': instance.expires_in,
    };
