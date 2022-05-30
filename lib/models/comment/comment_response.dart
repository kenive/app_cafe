import 'package:app_cafe/models/comment/comment_admin.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment_response.g.dart';

@JsonSerializable()
class CommentResponse {
  bool success;
  int? total_rows;
  int? total_pages;
  int? current_page;
  int? rows_per_page;
  List<CommentAdmin>? data;

  CommentResponse({
    required this.success,
    required this.total_rows,
    required this.total_pages,
    required this.current_page,
    required this.rows_per_page,
    this.data,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}
