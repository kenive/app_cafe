import 'package:json_annotation/json_annotation.dart';
part 'comment_data.g.dart';

@JsonSerializable()
class CommentData {
  bool success;
  String message;

  CommentData({required this.success, required this.message});

  factory CommentData.fromJson(Map<String, dynamic> json) =>
      _$CommentDataFromJson(json);

  Map<String, dynamic> toJson() => _$CommentDataToJson(this);
}
