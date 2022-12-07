import 'package:json_annotation/json_annotation.dart';

part 'template_info.g.dart';

@JsonSerializable()
class TemplateInfo {
  final String templateName;
  final List<String> likesMenu;
  final List<String> dislikesMenu;

  TemplateInfo({
    required this.templateName,
    required this.likesMenu,
    required this.dislikesMenu,
  });

  factory TemplateInfo.fromJson(Map<String, dynamic> json) =>
      _$TemplateInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateInfoToJson(this);
}

@JsonSerializable()
class TemplateInfoResponse {
  final int status;
  final bool success;
  final String message;
  final TemplateInfo data;

  TemplateInfoResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory TemplateInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$TemplateInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateInfoResponseToJson(this);
}