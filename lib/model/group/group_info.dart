import 'package:json_annotation/json_annotation.dart';

part 'group_info.g.dart';

@JsonSerializable()
class MemberInfo{
  final String email;
  final String nickname;

  MemberInfo({
    required this.email,
    required this.nickname,
  });

  factory MemberInfo.fromJson(Map<String, dynamic> json) =>
      _$MemberInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MemberInfoToJson(this);
}

@JsonSerializable()
class GroupInfo{
  final String groupId;
  final MemberInfo data;

  GroupInfo({
    required this.groupId,
    required this.data,
  });

  factory GroupInfo.fromJson(Map<String, dynamic> json) =>
      _$GroupInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GroupInfoToJson(this);
}

@JsonSerializable()
class GroupInfoResponse{
  final int status;
  final bool success;
  final String message;
  final GroupInfo data;

  GroupInfoResponse({required this.status, required this.success, required this.message, required this.data});

  factory GroupInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupInfoResponseToJson(this);
}