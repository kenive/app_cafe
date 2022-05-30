import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  bool success;

  String access_token;

  String token_type;

  int expires_in;

  User(
      {required this.access_token,
      required this.success,
      required this.token_type,
      required this.expires_in});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
