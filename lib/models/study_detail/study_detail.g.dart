// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyDetailData _$StudyDetailDataFromJson(Map<String, dynamic> json) =>
    StudyDetailData(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : CategoryDetailData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$StudyDetailDataToJson(StudyDetailData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
