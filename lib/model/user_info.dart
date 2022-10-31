import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo{
  final String email;
  final String nickname;
  final String accessToken;

  UserInfo({
    required this.email,
    required this.nickname,
    required this.accessToken
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

}