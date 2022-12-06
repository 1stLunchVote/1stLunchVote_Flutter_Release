// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberInfo _$MemberInfoFromJson(Map<String, dynamic> json) => MemberInfo(
      email: json['email'] as String,
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$MemberInfoToJson(MemberInfo instance) =>
    <String, dynamic>{
      'email': instance.email,
      'nickname': instance.nickname,
    };

GroupInfo _$GroupInfoFromJson(Map<String, dynamic> json) => GroupInfo(
      groupId: json['groupId'] as String,
      data: MemberInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GroupInfoToJson(GroupInfo instance) => <String, dynamic>{
      'groupId': instance.groupId,
      'data': instance.data,
    };

GroupInfoResponse _$GroupInfoResponseFromJson(Map<String, dynamic> json) =>
    GroupInfoResponse(
      status: json['status'] as int,
      success: json['success'] as bool,
      message: json['message'] as String,
      data: GroupInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GroupInfoResponseToJson(GroupInfoResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
