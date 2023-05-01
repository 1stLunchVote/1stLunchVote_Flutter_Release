
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/repository/login_repository.dart';

import '../routes/app_pages.dart';

class LoginController extends GetxController{
  final LoginRepository repository;
  LoginController({required this.repository});

  final RxBool _loginLoading = false.obs;
  bool get loginLoading => _loginLoading.value;

  final RxBool _pwdVisible = false.obs;
  bool get pwdVisible => _pwdVisible.value;

  final RxString _showToast = "".obs;
  String get showToast => _showToast.value;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();


  changePwdVisible(){
    _pwdVisible.value = !_pwdVisible.value;
  }


  googleLogin(){
    _loginLoading.value = true;
    repository.signInWithGoogle().then((value) {
      createUser(value.user?.uid, value.user?.email, value.user?.displayName, value.user?.photoURL);
    }, onError: (e){
      _loginLoading.value = false;
      print(e.message);
      _showToast.value = e.message!;
    });
  }

  createUser(String? uid, String? email, String? name, String? imageUrl){
    repository.createUser(uid, name, email, imageUrl).then((value) {
      Get.offNamed(Routes.home);
      print("로그인 성공");
    }, onError: (e){
      _loginLoading.value = false;
      print(e.message);
      _showToast.value = "회원가입에 실패했습니다.";
    });
  }

  // Future<UserCredential> signInWithApple() async {
  //   final appleProvider = AppleAuthProvider();
  //   if (kIsWeb) {
  //     await FirebaseAuth.instance.signInWithPopup(appleProvider);
  //   } else {
  //     await FirebaseAuth.instance.signInWithProvider(appleProvider);
  //   }
  // }

  // postUserToken(String accessToken) async{
  //   SharedPrefManager spfManager = Get.find<SharedPrefManager>();
  //   String? fcmToken = await spfManager.getFCMToken();
  //   if (fcmToken == null){
  //     fcmToken = await FirebaseMessaging.instance.getToken();
  //     spfManager.setFCMToken(fcmToken);
  //   }
  //   // 로그인 오류 날 시 카카오 언링크 후
  //   repository.createUser(accessToken, fcmToken!).then((value) {
  //     if (value.success){
  //       _loginState.value = LoginSuccess();
  //       LunchVoteDioProvider.setOptions(value.data.accessToken);
  //       // 유저 토큰 세팅
  //       spfManager.setUserToken(value.data.accessToken);
  //       // 홈화면으로 이동
  //       Get.offAllNamed(Routes.home);
  //     } else {
  //       // 로그인 에러
  //       repository.unlink();
  //       _loginState.value = LoginError(value.message);
  //     }
  //   }, onError: (e){
  //     repository.unlink();
  //     _loginState.value = LoginError(e.message);
  //
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(
  //       const SnackBar(content: Text("로그인에 실패하였습니다. 다시 로그인해주세요."))
  //     );
  //   });
  // }
}