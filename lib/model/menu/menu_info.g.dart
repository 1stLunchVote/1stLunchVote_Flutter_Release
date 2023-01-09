// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuInfoResponse _$MenuInfoResponseFromJson(Map<String, dynamic> json) =>
    MenuInfoResponse(
      status: json['status'] as int,
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => MenuInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuInfoResponseToJson(MenuInfoResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

MenuInfo _$MenuInfoFromJson(Map<String, dynamic> json) => MenuInfo(
      menuId: json['menuId'] as String,
      menuName: json['menuName'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$MenuInfoToJson(MenuInfo instance) => <String, dynamic>{
      'menuId': instance.menuId,
      'menuName': instance.menuName,
      'image': instance.image,
    };
