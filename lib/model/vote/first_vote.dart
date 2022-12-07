import 'package:json_annotation/json_annotation.dart';

part 'first_vote.g.dart';

@JsonSerializable()
class FirstVoteItem{
  final String templateId;
  FirstVoteItem({required this.templateId});

  factory FirstVoteItem.fromJson(Map<String, dynamic> json) => _$FirstVoteItemFromJson(json);
  Map<String, dynamic> toJson() => _$FirstVoteItemToJson(this);
}

@JsonSerializable()
class FirstVoteData{
  final int count;
  FirstVoteData({required this.count});

  factory FirstVoteData.fromJson(Map<String, dynamic> json) => _$FirstVoteDataFromJson(json);
  Map<String, dynamic> toJson() => _$FirstVoteDataToJson(this);
}

@JsonSerializable()
class FirstVoteResponse{
  final int status;
  final bool success;
  final String message;
  final FirstVoteData data;

  FirstVoteResponse({required this.status, required this.success, required this.message, required this.data});

  factory FirstVoteResponse.fromJson(Map<String, dynamic> json) => _$FirstVoteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FirstVoteResponseToJson(this);
}