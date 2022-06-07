import 'package:app_cafe/models/categories_detail/detail_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'detail_response.g.dart';

@JsonSerializable()
class CategoryDetailResponse {
  bool success;
  String? message;
  List<CategoryDetailData>? data;

  CategoryDetailResponse({
    this.message,
    required this.success,
    this.data,
  });

  factory CategoryDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDetailResponseToJson(this);
}
