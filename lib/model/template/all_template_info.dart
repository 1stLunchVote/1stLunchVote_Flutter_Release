import 'package:json_annotation/json_annotation.dart';

part 'all_template_info.g.dart';


@JsonSerializable()
class AllTemplateResponse{
  final int status;
  final String message;
  final bool success;
  final List<AllTemplateInfo> data;

  AllTemplateResponse({required this.status, required this.message, required this.success, required this.data});

  factory AllTemplateResponse.fromJson(Map<String, dynamic> json) =>
      _$AllTemplateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllTemplateResponseToJson(this);
}

@JsonSerializable()
class AllTemplateInfo{
  final String lunchTemplateId;
  final String templateName;

  AllTemplateInfo({required this.lunchTemplateId, required this.templateName});

  factory AllTemplateInfo.fromJson(Map<String, dynamic> json) =>
      _$AllTemplateInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AllTemplateInfoToJson(this);
}