import 'package:app_cafe/models/categories_detail/detail_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'study_detail.g.dart';

@JsonSerializable()
class StudyDetailData {
  bool success;
  String? message;
  CategoryDetailData? data;

  StudyDetailData({required this.success, this.data, this.message});

  factory StudyDetailData.fromJson(Map<String, dynamic> json) =>
      _$StudyDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$StudyDetailDataToJson(this);
}
