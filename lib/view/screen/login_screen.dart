import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/home_screen.dart';
import 'package:lunch_vote/controller/login_controller.dart';
import 'package:lunch_vote/view/widget/utils/shared_pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = LoginController();
  SharedPrefManager spfManager = SharedPrefManager();

  // @override
  // void initState() {
  //   setLoginVisibility();
  //   super.initState();
  // }
  //
  // void setLoginVisibility() async {
  //   var token = await spfManager.getUserToken();
  //   if (token == null) {
  //     setState(() {
  //       _isLoginVisible = true;
  //       FlutterNativeSplash.remove();
  //     });
  //   } else {
  //     print('User Token : $token');
  //     navigateToHome();
  //     FlutterNativeSplash.remove();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        // Android Status Bar Color
        statusBarIconBrightness: Brightness.dark
      )
    );
    ScreenUtil.init(context, designSize: const Size(360, 800));
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/ic_launcher.png",
                  width: 100,
                  height: 100,
                )
              ),
            ),
            Expanded(
                child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: MaterialButton(
                  onPressed: () async {
                    String? accessToken = await _loginController.loginToken();
                    print('Access Token : $accessToken');
                    String? userToken =
                        await _loginController.postUserToken(accessToken!);
                    print('User Token : $userToken');
                    spfManager.setUserToken(userToken!);
                    navigateToHome();
                  },
                  child: Image.asset(
                    'assets/images/bg_kakao_login.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  void navigateToHome() {
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
