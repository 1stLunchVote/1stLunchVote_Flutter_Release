import 'package:json_annotation/json_annotation.dart';

part 'user_invite.g.dart';

@JsonSerializable()
class UserInviteInfo{
  final String email;
  final String nickname;
  final String profileImage;

  UserInviteInfo({
    required this.email,
    required this.nickname,
    required this.profileImage,
  });

  factory UserInviteInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInviteInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInviteInfoToJson(this);
}

@JsonSerializable()
class UserInviteResponse{
  final int status;
  final bool success;
  final String message;
  final UserInviteInfo data;

  UserInviteResponse({required this.status, required this.success, required this.message, required this.data});

  factory UserInviteResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInviteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserInviteResponseToJson(this);
}

@JsonSerializable()
class UserEmail{
  final String email;

  UserEmail({required this.email});

  factory UserEmail.fromJson(Map<String, dynamic> json) =>
      _$UserEmailFromJson(json);

  Map<String, dynamic> toJson() => _$UserEmailToJson(this);
}