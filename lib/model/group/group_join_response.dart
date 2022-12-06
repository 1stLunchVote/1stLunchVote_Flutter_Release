import 'package:json_annotation/json_annotation.dart';

part 'group_join_response.g.dart';

@JsonSerializable()
class GroupJoinResponse{
  final int status;
  final bool success;
  final String message;

  GroupJoinResponse({required this.status, required this.success, required this.message});

  factory GroupJoinResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupJoinResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupJoinResponseToJson(this);
}