// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSearch _$UserSearchFromJson(Map<String, dynamic> json) => UserSearch(
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$UserSearchToJson(UserSearch instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
    };

UserSearchResponse _$UserSearchResponseFromJson(Map<String, dynamic> json) =>
    UserSearchResponse(
      status: json['status'] as int,
      success: json['success'] as bool,
      message: json['message'] as String,
      data: UserInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserSearchResponseToJson(UserSearchResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
