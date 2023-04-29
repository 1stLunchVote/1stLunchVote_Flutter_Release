import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginRepository{
  final FirebaseAuth _firebaseAuth;

  LoginRepository(this._firebaseAuth);

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return _firebaseAuth.signInWithCredential(credential);
  }

  // Future<String?> login() async{
  //   if (await isKakaoTalkInstalled()){
  //     try {
  //       OAuthToken token = await kakaoInstance.loginWithKakaoTalk();
  //       return token.accessToken;
  //     } catch (error) {
  //       if (error is PlatformException && error.code == 'CANCELED') {
  //         return null;
  //       }
  //       // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
  //       try {
  //         OAuthToken token = await kakaoInstance.loginWithKakaoAccount();
  //         print('카카오계정으로 로그인 성공');
  //         return token.accessToken;
  //       } catch (error) {
  //         print('카카오계정으로 로그인 실패 $error');
  //         return null;
  //       }
  //     }
  //
  //   } else {
  //     try {
  //       OAuthToken token = await kakaoInstance.loginWithKakaoAccount();
  //       print('카카오계정으로 로그인 성공');
  //       return token.accessToken;
  //     } catch (error) {
  //       print('카카오계정으로 로그인 실패 $error');
  //       return null;
  //     }
  //   }
  // }
  //
  // Future<bool> unlink() async{
  //   try{
  //     await kakaoInstance.unlink();
  //     print("kakao 탈퇴");
  //     return true;
  //   }catch (error){
  //     return false;
  //   }
  // }
  //
  // Future<UserInfoResponse> createUser(String accessToken, String fcmToken) {
  //   return lunchVoteService.postUserToken(SocialToken(socialToken: accessToken, fcmToken: fcmToken));
  // }
}