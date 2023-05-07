
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/repository/profile_repository.dart';

import '../routes/app_pages.dart';
import '../view/widget/awesome_dialog.dart';

class ProfileController extends GetxController{
  final ProfileRepository _repository;
  ProfileController(this._repository);

  final RxString _nickname = "".obs;
  String get nickname => _nickname.value;

  final RxString _imageUrl = "".obs;
  String get imageUrl => _imageUrl.value;

  final RxBool _nicknameChange = false.obs;
  bool get nicknameChange => _nicknameChange.value;

  final TextEditingController nickNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();


  getUserInfo(){
    _repository.getUserInfo().listen((value) {
      _nickname.value = value.nickname;
      _imageUrl.value = value.profileImage ?? "";
    });
  }

  onClickComplete(){
    if (nicknameChange){
      // 닉네임 변경
      if (formKey.currentState!.validate()){
        formKey.currentState!.save();
        changeNickname();
      }
    } else {
      // 로그아웃
      _showDialog(Get.context!).then((value) {
        if(value) {
          logout();
        }
      });
    }
  }

  changeNickname() {
    _repository.updateUserNickname(nickNameController.text).then((value) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
            content: Text(
                '닉네임 변경에 성공 하였습니다.')));
      }
    });
    setNicknameChange();
  }
  // getProfileInfo() {
  //   repository.getProfileInfo().then((value) {
  //     if (value.success){
  //       _profileData.value = value.data;
  //     }
  //   });
  // }

  logout() async{
    _repository.logout().then((value) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text(
              '로그아웃 되었습니다.')));
      Get.offAllNamed(Routes.login);
    });
  }

  setNicknameChange(){
    _nicknameChange.value = !_nicknameChange.value;
  }

  Future<bool> _showDialog(BuildContext context) async{
    var res = await LunchAwesomeDialog(
      context: context,
      title: "로그아웃",
      body: "정말로 로그아웃 하시겠습니까?",
      okText: '예',
      cancelText: '아니오',
    ).showDialog();

    return Future.value(res);
  }
}