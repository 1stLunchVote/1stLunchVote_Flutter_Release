import 'package:json_annotation/json_annotation.dart';

part 'vote_state.g.dart';

@JsonSerializable()
class VoteState{
  final bool finish;

  VoteState({required this.finish});

  factory VoteState.fromJson(Map<String, dynamic> json) => _$VoteStateFromJson(json);
  Map<String, dynamic> toJson() => _$VoteStateToJson(this);
}

@JsonSerializable()
class VoteStateResponse{
  final int status;
  final bool success;
  final String message;
  final VoteState data;

  VoteStateResponse({required this.status, required this.success, required this.message, required this.data});

  factory VoteStateResponse.fromJson(Map<String, dynamic> json) => _$VoteStateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VoteStateResponseToJson(this);
}