// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesReponse _$CategoriesReponseFromJson(Map<String, dynamic> json) =>
    CategoriesReponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => CategoriesData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoriesReponseToJson(CategoriesReponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
