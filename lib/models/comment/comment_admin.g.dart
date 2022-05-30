// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentAdmin _$CommentAdminFromJson(Map<String, dynamic> json) => CommentAdmin(
      id: json['id'] as int,
      bai_viet_id: json['bai_viet_id'] as int,
      ho_ten: json['ho_ten'] as String,
      email: json['email'] as String?,
      dienThoai: json['dienThoai'] as String?,
      noi_dung: json['noi_dung'] as String,
      duyet: json['duyet'] as int,
      nguoi_tra_loi: json['nguoi_tra_loi'] as int?,
      created_at: json['created_at'] as String,
      nguoi_duyet: json['nguoi_duyet'] as int?,
    );

Map<String, dynamic> _$CommentAdminToJson(CommentAdmin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bai_viet_id': instance.bai_viet_id,
      'ho_ten': instance.ho_ten,
      'email': instance.email,
      'dienThoai': instance.dienThoai,
      'noi_dung': instance.noi_dung,
      'nguoi_tra_loi': instance.nguoi_tra_loi,
      'duyet': instance.duyet,
      'created_at': instance.created_at,
      'nguoi_duyet': instance.nguoi_duyet,
    };
