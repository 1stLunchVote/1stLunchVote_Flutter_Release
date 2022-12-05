// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nickname _$NicknameFromJson(Map<String, dynamic> json) => Nickname(
      nickname: json['nickname'] as String?,
    );

Map<String, dynamic> _$NicknameToJson(Nickname instance) => <String, dynamic>{
      'nickname': instance.nickname,
    };

NicknameResponse _$NicknameResponseFromJson(Map<String, dynamic> json) =>
    NicknameResponse(
      status: json['status'] as int,
      success: json['success'] as bool,
      message: json['message'] as String,
      data: Nickname.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NicknameResponseToJson(NicknameResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

ProfileInfo _$ProfileInfoFromJson(Map<String, dynamic> json) => ProfileInfo(
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      profileImage: json['profileImage'] as String,
    );

Map<String, dynamic> _$ProfileInfoToJson(ProfileInfo instance) =>
    <String, dynamic>{
      'email': instance.email,
      'nickname': instance.nickname,
      'profileImage': instance.profileImage,
    };

ProfileInfoResponse _$ProfileInfoResponseFromJson(Map<String, dynamic> json) =>
    ProfileInfoResponse(
      status: json['status'] as int,
      success: json['success'] as bool,
      message: json['message'] as String,
      data: ProfileInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileInfoResponseToJson(
        ProfileInfoResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
