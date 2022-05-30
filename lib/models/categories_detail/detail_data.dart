import 'package:json_annotation/json_annotation.dart';
part 'detail_data.g.dart';

@JsonSerializable()
class CategoryDetailData {
  int id;
  int danh_muc_id;
  String tieu_de;
  String slug;
  String hinh_anh;
  String noi_dung;
  int nguoi_dang;
  String? createdAt;

  CategoryDetailData({
    required this.id,
    required this.danh_muc_id,
    required this.tieu_de,
    required this.slug,
    required this.hinh_anh,
    required this.noi_dung,
    required this.nguoi_dang,
    this.createdAt,
  });

  factory CategoryDetailData.fromJson(Map<String, dynamic> json) =>
      _$CategoryDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDetailDataToJson(this);
}
