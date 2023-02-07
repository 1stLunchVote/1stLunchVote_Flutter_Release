import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:lunch_vote/provider/lunch_vote_service.dart';

import '../model/login/user_info.dart';

class LoginRepository{
  final LunchVoteService lunchVoteService;
  LoginRepository({required this.lunchVoteService});

  final kakaoInstance = UserApi.instance;

  Future<String?> login() async{
    if (await isKakaoTalkInstalled()){
      try {
        OAuthToken token = await kakaoInstance.loginWithKakaoTalk();
        return token.accessToken;
      } catch (error) {
        if (error is PlatformException && error.code == 'CANCELED') {
          return null;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await kakaoInstance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
          return token.accessToken;
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
          return null;
        }
      }

    } else {
      try {
        OAuthToken token = await kakaoInstance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
        return token.accessToken;
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
        return null;
      }
    }
  }

  Future<bool> unlink() async{
    try{
      await kakaoInstance.unlink();
      print("kakao 탈퇴");
      return true;
    }catch (error){
      return false;
    }
  }

  Future<UserInfoResponse> createUser(String accessToken, String fcmToken) {
    return lunchVoteService.postUserToken(SocialToken(socialToken: accessToken, fcmToken: fcmToken));
  }
}