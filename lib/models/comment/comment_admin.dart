import 'package:json_annotation/json_annotation.dart';
part 'comment_admin.g.dart';

@JsonSerializable()
class CommentAdmin {
  int id;
  int bai_viet_id;
  String ho_ten;
  String? email;
  String? dienThoai;
  String noi_dung;
  int? nguoi_tra_loi;
  int duyet;
  String created_at;
  int? nguoi_duyet;

  CommentAdmin({
    required this.id,
    required this.bai_viet_id,
    required this.ho_ten,
    this.email,
    this.dienThoai,
    required this.noi_dung,
    required this.duyet,
    this.nguoi_tra_loi,
    required this.created_at,
    this.nguoi_duyet,
  });

  factory CommentAdmin.fromJson(Map<String, dynamic> json) =>
      _$CommentAdminFromJson(json);

  Map<String, dynamic> toJson() => _$CommentAdminToJson(this);
}
