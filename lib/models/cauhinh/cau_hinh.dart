import 'package:json_annotation/json_annotation.dart';
part 'cau_hinh.g.dart';

@JsonSerializable()
class Setting {
  bool success;
  Data? data;

  Setting({required this.success, this.data});

  factory Setting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);
}

@JsonSerializable()
class Data {
  Data({
    required this.id,
    required this.name,
    required this.value,
  });

  int id;
  String name;
  String value;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
