import 'package:json_annotation/json_annotation.dart';

part 'first_vote_result.g.dart';

@JsonSerializable()
class FirstVoteResult{
  final List<MenuInfo> menuInfos;

  FirstVoteResult({
    required this.menuInfos
  });

  factory FirstVoteResult.fromJson(Map<String, dynamic> json) => _$FirstVoteResultFromJson(json);
  Map<String, dynamic> toJson() => _$FirstVoteResultToJson(this);
}

@JsonSerializable()
class FirstVoteResultResponse{
  final int status;
  final bool success;
  final String message;
  final FirstVoteResult data;

  FirstVoteResultResponse({required this.status, required this.success, required this.message, required this.data});

  factory FirstVoteResultResponse.fromJson(Map<String, dynamic> json) => _$FirstVoteResultResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FirstVoteResultResponseToJson(this);
}

@JsonSerializable()
class MenuInfo{
  final String menuId;
  final String menuName;
  final String image;

  MenuInfo({required this.menuId, required this.menuName, required this.image});

  factory MenuInfo.fromJson(Map<String, dynamic> json) => _$MenuInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MenuInfoToJson(this);
}