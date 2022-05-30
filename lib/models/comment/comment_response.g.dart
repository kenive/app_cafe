// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) =>
    CommentResponse(
      success: json['success'] as bool,
      total_rows: json['total_rows'] as int?,
      total_pages: json['total_pages'] as int?,
      current_page: json['current_page'] as int?,
      rows_per_page: json['rows_per_page'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CommentAdmin.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentResponseToJson(CommentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'total_rows': instance.total_rows,
      'total_pages': instance.total_pages,
      'current_page': instance.current_page,
      'rows_per_page': instance.rows_per_page,
      'data': instance.data,
    };
