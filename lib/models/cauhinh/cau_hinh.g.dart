// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cau_hinh.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Setting _$SettingFromJson(Map<String, dynamic> json) => Setting(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SettingToJson(Setting instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as int,
      name: json['name'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'value': instance.value,
    };
