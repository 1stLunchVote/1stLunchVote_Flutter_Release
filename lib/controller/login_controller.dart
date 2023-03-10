import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:dio/dio.dart';
import 'package:lunch_vote/model/login/user_info.dart';
import 'package:lunch_vote/provider/lunch_vote_service.dart';

import '../utils/shared_pref_manager.dart';

class LoginController extends GetxController{
  final SharedPrefManager _spfManager = SharedPrefManager();
  late LunchVoteService _lunchVoteService;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  LoginController(){
    final dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));
  }


  Future<bool> login() async{
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        return true;
      } catch (error) {
        if (error is PlatformException && error.code == 'CANCELED') {
          return false;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
          return true;
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
          return false;
        }
      }
    } else{
      try {
        await UserApi.instance.loginWithKakaoAccount();
        return true;
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
        return false;
      }
    }
  }

  Future<bool> logout() async{
    try{
      await UserApi.instance.unlink();
      return true;
    }catch (error){
      return false;
    }
  }

  Future<String?> loginToken() async{
    if (await isKakaoTalkInstalled()){
      try {
        _isLoading.value = true;
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        return token.accessToken;
      } catch (error) {
        if (error is PlatformException && error.code == 'CANCELED') {
          return null;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
          return token.accessToken;
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
          _isLoading.value = false;
          return null;
        }
      }

    } else {
      try {
        _isLoading.value = true;
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
        return token.accessToken;
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
        _isLoading.value = false;
        return null;
      }
    }
  }

  Future<String?> postUserToken(String accessToken) async{
    String? fcmToken = await _spfManager.getFCMToken();
    if (fcmToken == null){
      fcmToken = await FirebaseMessaging.instance.getToken();
      _spfManager.setFCMToken(fcmToken);
    }
    final result = await _lunchVoteService.postUserToken(SocialToken(socialToken: accessToken, fcmToken: fcmToken));
    _isLoading.value = false;
    return result.data.accessToken;
  }
}