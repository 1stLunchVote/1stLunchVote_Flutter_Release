import 'package:json_annotation/json_annotation.dart';

part 'profile_info.g.dart';

@JsonSerializable()
class Nickname{
  String? nickname;

  Nickname({
    required this.nickname
  });

  factory Nickname.fromJson(Map<String, dynamic> json) => _$NicknameFromJson(json);
  Map<String, dynamic> toJson() => _$NicknameToJson(this);
}

@JsonSerializable()
class NicknameResponse{
  final int status;
  final bool success;
  final String message;
  final Nickname data;

  NicknameResponse({required this.status, required this.success, required this.message, required this.data});

  factory NicknameResponse.fromJson(Map<String, dynamic> json) =>
      _$NicknameResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NicknameResponseToJson(this);
}
