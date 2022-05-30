import 'package:app_cafe/models/categories/categories.dart';
import 'package:json_annotation/json_annotation.dart';
part 'categories_data.g.dart';

@JsonSerializable()
class CategoriesReponse {
  bool success;
  List<CategoriesData> data;
  CategoriesReponse({
    required this.success,
    required this.data,
  });

  factory CategoriesReponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesReponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesReponseToJson(this);
}
