// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesData _$CategoriesDataFromJson(Map<String, dynamic> json) =>
    CategoriesData(
      id: json['id'] as int,
      ten: json['ten'] as String,
      ten_day_du: json['ten_day_du'] as String,
      slug: json['slug'] as String,
      hinh_anh: json['hinh_anh'] as String,
      mo_ta: json['mo_ta'] as String?,
      created_at: json['created_at'] as String,
    );

Map<String, dynamic> _$CategoriesDataToJson(CategoriesData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ten': instance.ten,
      'slug': instance.slug,
      'ten_day_du': instance.ten_day_du,
      'hinh_anh': instance.hinh_anh,
      'mo_ta': instance.mo_ta,
      'created_at': instance.created_at,
    };
