import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/model/login/login_state.dart';
import 'package:lunch_vote/provider/lunch_vote_dio_provider.dart';
import 'package:lunch_vote/repository/login_repository.dart';
import 'package:lunch_vote/utils/shared_pref_manager.dart';

import '../routes/app_pages.dart';

class LoginController extends GetxController{
  final LoginRepository repository;
  LoginController({required this.repository});

  final Rx<LoginState> _loginState = LoginInitial().obs;
  LoginState get loginState => _loginState.value;

  final RxBool _pwdVisible = false.obs;
  bool get pwdVisible => _pwdVisible.value;

  changePwdVisible(){
    _pwdVisible.value = !_pwdVisible.value;
  }

  kakaoLogin(){
    _loginState.value = LoginLoading();
    repository.login().then((value) {
        // value가 null이 아닌 경우 서버로 로그인
        if (value != null){
          postUserToken(value);
        } else {
          _loginState.value = LoginInitial();
        }
      }
    );
  }

  postUserToken(String accessToken) async{
    SharedPrefManager spfManager = Get.find<SharedPrefManager>();
    String? fcmToken = await spfManager.getFCMToken();
    if (fcmToken == null){
      fcmToken = await FirebaseMessaging.instance.getToken();
      spfManager.setFCMToken(fcmToken);
    }
    // 로그인 오류 날 시 카카오 언링크 후
    repository.createUser(accessToken, fcmToken!).then((value) {
      if (value.success){
        _loginState.value = LoginSuccess();
        LunchVoteDioProvider.setOptions(value.data.accessToken);
        // 유저 토큰 세팅
        spfManager.setUserToken(value.data.accessToken);
        // 홈화면으로 이동
        Get.offAllNamed(Routes.home);
      } else {
        // 로그인 에러
        repository.unlink();
        _loginState.value = LoginError(value.message);
      }
    }, onError: (e){
      repository.unlink();
      _loginState.value = LoginError(e.message);

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text("로그인에 실패하였습니다. 다시 로그인해주세요."))
      );
    });
  }
}