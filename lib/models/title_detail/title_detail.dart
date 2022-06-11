import 'package:json_annotation/json_annotation.dart';
part 'title_detail.g.dart';

@JsonSerializable()
class TitleDetail {
  bool success;
  TitleData data;

  TitleDetail({required this.success, required this.data});

  factory TitleDetail.fromJson(Map<String, dynamic> json) =>
      _$TitleDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TitleDetailToJson(this);
}

@JsonSerializable()
class TitleData {
  int id;
  @JsonKey(name: 'danh_muc_id')
  int danhMucId;
  @JsonKey(name: 'tieu_de')
  String tieuDe;
  @JsonKey(name: 'slug')
  String slug;
  @JsonKey(name: 'hinh_anh')
  String hinhAnh;
  @JsonKey(name: 'noi_dung')
  Content? noiDung;
  @JsonKey(name: 'nguoi_dang')
  int nguoiDang;

  TitleData(
      {required this.id,
      required this.danhMucId,
      required this.tieuDe,
      required this.slug,
      required this.hinhAnh,
      required this.nguoiDang,
      this.noiDung});

  factory TitleData.fromJson(Map<String, dynamic> json) =>
      _$TitleDataFromJson(json);

  Map<String, dynamic> toJson() => _$TitleDataToJson(this);
}

@JsonSerializable()
class Content {
  @JsonKey(name: 'gioi_thieu')
  String? gioiThieu;
  @JsonKey(name: 'chi_tiet')
  List<ContentDetail> detail;

  Content({this.gioiThieu, required this.detail});

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable()
class ContentDetail {
  @JsonKey(name: 'de_muc')
  String deMuc;
  @JsonKey(name: 'noi_dung')
  String noiDung;

  ContentDetail({required this.deMuc, required this.noiDung});

  factory ContentDetail.fromJson(Map<String, dynamic> json) =>
      _$ContentDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ContentDetailToJson(this);
}
