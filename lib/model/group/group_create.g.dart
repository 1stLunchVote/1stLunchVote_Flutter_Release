// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupCreateResponse _$GroupCreateResponseFromJson(Map<String, dynamic> json) =>
    GroupCreateResponse(
      status: json['status'] as int,
      success: json['success'] as bool,
      message: json['message'] as String,
      data: GroupInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GroupCreateResponseToJson(
        GroupCreateResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
