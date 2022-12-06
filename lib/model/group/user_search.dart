import 'package:json_annotation/json_annotation.dart';

import '../login/user_info.dart';

part 'user_search.g.dart';

@JsonSerializable()
class UserSearch{
  final String nickname;

  UserSearch({
    required this.nickname,
  });

  factory UserSearch.fromJson(Map<String, dynamic> json) =>
      _$UserSearchFromJson(json);

  Map<String, dynamic> toJson() => _$UserSearchToJson(this);
}

@JsonSerializable()
class UserSearchResponse{
  final int status;
  final bool success;
  final String message;
  final UserInfo data;

  UserSearchResponse({required this.status, required this.success, required this.message, required this.data});

  factory UserSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserSearchResponseToJson(this);
}