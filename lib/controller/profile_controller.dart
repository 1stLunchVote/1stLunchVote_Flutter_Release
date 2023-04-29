import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/controller/nickname_controller.dart';
import 'package:lunch_vote/model/profile/profile_info.dart';
import 'package:lunch_vote/provider/lunch_vote_service.dart';
import 'package:lunch_vote/repository/profile_repository.dart';
import 'package:lunch_vote/utils/shared_pref_manager.dart';

import '../routes/app_pages.dart';
import '../view/widget/awesome_dialog.dart';

class ProfileController extends GetxController{
  final ProfileRepository repository;
  final NicknameController nicknameController;
  String get nickname => nicknameController.nickname;

  ProfileController({required this.repository, required this.nicknameController});

  final _profileData = Rx<ProfileInfo?>(null);
  ProfileInfo? get profileData => _profileData.value;

  final RxBool _nicknameChange = false.obs;
  bool get nicknameChange => _nicknameChange.value;

  changeNickname(String nickname) {
    repository.patchNickname(nickname).then((value) {
        if (value.success){
          nicknameController.setNickname(value.data.nickname!);
        }
        String complete = value.success ? '성공' : '실패';
        if (Get.context != null){
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
              content: Text(
                  '닉네임 변경에 $complete 하였습니다.')));
        }
      }
    );
    setNicknameChange(false);

  }

  getProfileInfo() {
    repository.getProfileInfo().then((value) {
      if (value.success){
        _profileData.value = value.data;
      }
    });
  }

  Future<void> logout() async{
    Get.find<SharedPrefManager>().clearUserToken();
    ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text(
            '로그아웃 되었습니다.')));
    Get.offAllNamed(Routes.login);
  }

  void setNicknameChange(bool change){
    _nicknameChange.value = change;
  }

  Future<bool> showDialog(BuildContext context) async{
    var res = await LunchAwesomeDialog(
      context: context,
      title: "방 나가기",
      body: "정말로 로그아웃 하시겠습니까?",
      okText: '예',
      cancelText: '아니오',
    ).showDialog();

    return Future.value(res);
  }
}