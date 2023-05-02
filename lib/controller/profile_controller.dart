
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/repository/profile_repository.dart';

import '../routes/app_pages.dart';
import '../view/widget/awesome_dialog.dart';

class ProfileController extends GetxController{
  final ProfileRepository repository;
  ProfileController(this.repository);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String get uid => _auth.currentUser?.uid ?? "";

  final RxString _nickname = "".obs;
  String get nickname => _nickname.value;

  final RxString _imageUrl = "".obs;
  String get imageUrl => _imageUrl.value;

  final RxBool _nicknameChange = false.obs;
  bool get nicknameChange => _nicknameChange.value;


  getUserInfo(){
    repository.getUserInfo(uid).listen((value) {
      _nickname.value = value.nickname;
      _imageUrl.value = value.profileImage ?? "";
    });
  }

  changeNickname(String nickname) {
    repository.updateUserNickname(uid, nickname).then((value) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
            content: Text(
                '닉네임 변경에 성공 하였습니다.')));
      }
    });
    setNicknameChange(false);
  }
  // getProfileInfo() {
  //   repository.getProfileInfo().then((value) {
  //     if (value.success){
  //       _profileData.value = value.data;
  //     }
  //   });
  // }

  Future<void> logout() async{
    // Get.find<SharedPrefManager>().clearUserToken();
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