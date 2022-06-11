// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'title_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TitleDetail _$TitleDetailFromJson(Map<String, dynamic> json) => TitleDetail(
      success: json['success'] as bool,
      data: TitleData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TitleDetailToJson(TitleDetail instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

TitleData _$TitleDataFromJson(Map<String, dynamic> json) => TitleData(
      id: json['id'] as int,
      danhMucId: json['danh_muc_id'] as int,
      tieuDe: json['tieu_de'] as String,
      slug: json['slug'] as String,
      hinhAnh: json['hinh_anh'] as String,
      nguoiDang: json['nguoi_dang'] as int,
      noiDung: json['noi_dung'] == null
          ? null
          : Content.fromJson(json['noi_dung'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TitleDataToJson(TitleData instance) => <String, dynamic>{
      'id': instance.id,
      'danh_muc_id': instance.danhMucId,
      'tieu_de': instance.tieuDe,
      'slug': instance.slug,
      'hinh_anh': instance.hinhAnh,
      'noi_dung': instance.noiDung,
      'nguoi_dang': instance.nguoiDang,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      gioiThieu: json['gioi_thieu'] as String?,
      detail: (json['chi_tiet'] as List<dynamic>)
          .map((e) => ContentDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'gioi_thieu': instance.gioiThieu,
      'chi_tiet': instance.detail,
    };

ContentDetail _$ContentDetailFromJson(Map<String, dynamic> json) =>
    ContentDetail(
      deMuc: json['de_muc'] as String,
      noiDung: json['noi_dung'] as String,
    );

Map<String, dynamic> _$ContentDetailToJson(ContentDetail instance) =>
    <String, dynamic>{
      'de_muc': instance.deMuc,
      'noi_dung': instance.noiDung,
    };
