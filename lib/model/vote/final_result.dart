import 'package:json_annotation/json_annotation.dart';

part 'final_result.g.dart';

@JsonSerializable()
class FinalResult{
  final String menuId;
  final String menuName;
  final String image;

  FinalResult({
    required this.menuId,
    required this.menuName,
    required this.image
  });

  factory FinalResult.fromJson(Map<String, dynamic> json) => _$FinalResultFromJson(json);
  Map<String, dynamic> toJson() => _$FinalResultToJson(this);
}

@JsonSerializable()
class FinalResultResponse{
  final int status;
  final bool success;
  final String message;
  final FinalResult data;

  FinalResultResponse({required this.status, required this.success, required this.message, required this.data});

  factory FinalResultResponse.fromJson(Map<String, dynamic> json) => _$FinalResultResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FinalResultResponseToJson(this);
}