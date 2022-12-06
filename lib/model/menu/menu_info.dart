import 'package:json_annotation/json_annotation.dart';

part 'menu_info.g.dart';


@JsonSerializable()
class MenuInfoResponse{
  final int status;
  final bool success;
  final String message;
  final MenuInfo data;

  MenuInfoResponse({required this.status, required this.success, required this.message, required this.data});

  factory MenuInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$MenuInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MenuInfoResponseToJson(this);
}


@JsonSerializable()
class MenuInfo{
  final String menuId;
  final String menuName;
  final String image;

  MenuInfo({required this.menuId, required this.menuName, required this.image});

  factory MenuInfo.fromJson(Map<String, dynamic> json) =>
      _$MenuInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MenuInfoToJson(this);
}