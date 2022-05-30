// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      access_token: json['access_token'] as String,
      success: json['success'] as bool,
      token_type: json['token_type'] as String,
      expires_in: json['expires_in'] as int,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'success': instance.success,
      'access_token': instance.access_token,
      'token_type': instance.token_type,
      'expires_in': instance.expires_in,
    };
