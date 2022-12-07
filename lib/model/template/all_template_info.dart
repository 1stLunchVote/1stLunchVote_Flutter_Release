import 'package:json_annotation/json_annotation.dart';

part 'all_template_info.g.dart';


@JsonSerializable()
class AllTemplateResponse{
  final int status;
  final String message;
  final bool success;
  final ResponseData data;

  AllTemplateResponse({required this.status, required this.message, required this.success, required this.data});

  factory AllTemplateResponse.fromJson(Map<String, dynamic> json) =>
      _$AllTemplateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllTemplateResponseToJson(this);
}

@JsonSerializable()
class ResponseData{
  final List<AllTemplateInfo> lunchTemplates;

  ResponseData({required this.lunchTemplates});

  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);

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

@JsonSerializable()
class OneTemplateResponse{
  final int status;
  final String message;
  final bool success;
  final OneResponseData data;

  OneTemplateResponse({required this.status, required this.message, required this.success, required this.data});

  factory OneTemplateResponse.fromJson(Map<String, dynamic> json) =>
      _$OneTemplateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OneTemplateResponseToJson(this);
}

@JsonSerializable()
class OneResponseData{
  final String templateName;
  final List<Menu> menu;

  OneResponseData({required this.templateName, required this.menu});

  factory OneResponseData.fromJson(Map<String, dynamic> json) =>
      _$OneResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$OneResponseDataToJson(this);

}

@JsonSerializable()
class Menu{
  final String menuId;
  final String menuName;
  final String image;
  final String likesAndDislikes;

  Menu({required this.menuId, required this.menuName, required this.image, required this.likesAndDislikes});

  factory Menu.fromJson(Map<String, dynamic> json) =>
      _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}