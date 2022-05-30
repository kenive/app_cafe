// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDetailData _$CategoryDetailDataFromJson(Map<String, dynamic> json) =>
    CategoryDetailData(
      id: json['id'] as int,
      danh_muc_id: json['danh_muc_id'] as int,
      tieu_de: json['tieu_de'] as String,
      slug: json['slug'] as String,
      hinh_anh: json['hinh_anh'] as String,
      noi_dung: json['noi_dung'] as String,
      nguoi_dang: json['nguoi_dang'] as int,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$CategoryDetailDataToJson(CategoryDetailData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'danh_muc_id': instance.danh_muc_id,
      'tieu_de': instance.tieu_de,
      'slug': instance.slug,
      'hinh_anh': instance.hinh_anh,
      'noi_dung': instance.noi_dung,
      'nguoi_dang': instance.nguoi_dang,
      'createdAt': instance.createdAt,
    };
