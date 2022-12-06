import 'package:json_annotation/json_annotation.dart';

import 'group_info.dart';

part 'group_create.g.dart';

@JsonSerializable()
class GroupCreateResponse{
  final int status;
  final bool success;
  final String message;
  final GroupInfo data;

  GroupCreateResponse({required this.status, required this.success, required this.message, required this.data});

  factory GroupCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupCreateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupCreateResponseToJson(this);
}