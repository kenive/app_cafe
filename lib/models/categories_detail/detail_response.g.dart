// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDetailResponse _$CategoryDetailResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryDetailResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => CategoryDetailData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryDetailResponseToJson(
        CategoryDetailResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
