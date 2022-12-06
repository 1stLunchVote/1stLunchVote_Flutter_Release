import 'package:json_annotation/json_annotation.dart';

part 'second_vote.g.dart';

@JsonSerializable()
class SecondVoteItem{
  final String menuId;
  SecondVoteItem({required this.menuId});

  factory SecondVoteItem.fromJson(Map<String, dynamic> json) => _$SecondVoteItemFromJson(json);
  Map<String, dynamic> toJson() => _$SecondVoteItemToJson(this);
}

@JsonSerializable()
class SecondVoteData{
  final int count;
  SecondVoteData({required this.count});

  factory SecondVoteData.fromJson(Map<String, dynamic> json) => _$SecondVoteDataFromJson(json);
  Map<String, dynamic> toJson() => _$SecondVoteDataToJson(this);
}

@JsonSerializable()
class SecondVoteResponse{
  final int status;
  final bool success;
  final String message;
  final SecondVoteData data;

  SecondVoteResponse({required this.status, required this.success, required this.message, required this.data});

  factory SecondVoteResponse.fromJson(Map<String, dynamic> json) => _$SecondVoteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SecondVoteResponseToJson(this);
}

@JsonSerializable()
class SecondVoteState{
  final bool finish;

  SecondVoteState({required this.finish});

  factory SecondVoteState.fromJson(Map<String, dynamic> json) => _$SecondVoteStateFromJson(json);
  Map<String, dynamic> toJson() => _$SecondVoteStateToJson(this);
}

@JsonSerializable()
class SecondVoteStateResponse{
  final int status;
  final bool success;
  final String message;
  final SecondVoteState data;

  SecondVoteStateResponse({required this.status, required this.success, required this.message, required this.data});

  factory SecondVoteStateResponse.fromJson(Map<String, dynamic> json) => _$SecondVoteStateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SecondVoteStateResponseToJson(this);
}