import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:lunch_vote/model/user.dart';

class LoginController{
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
      await UserApi.instance.logout();
      return true;
    }catch (error){
      return false;
    }
  }

  Future<UserInfo?> getUserInfo() async{
    try{
      User user = await UserApi.instance.me();
      return UserInfo(
          userID: user.id.toString(), userNickName: user.kakaoAccount?.profile?.nickname, userProfileImagePath: user.kakaoAccount?.profile?.profileImageUrl);
    }catch (error){
      return null;
    }
  }
}