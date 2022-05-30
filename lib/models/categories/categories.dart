import 'package:json_annotation/json_annotation.dart';
part 'categories.g.dart';

@JsonSerializable()
class CategoriesData {
  int id;
  String ten;
  String slug;
  String ten_day_du;
  String hinh_anh;
  String? mo_ta;
  String created_at;

  CategoriesData({
    required this.id,
    required this.ten,
    required this.ten_day_du,
    required this.slug,
    required this.hinh_anh,
    this.mo_ta,
    required this.created_at,
  });

  factory CategoriesData.fromJson(Map<String, dynamic> json) =>
      _$CategoriesDataFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesDataToJson(this);
}
