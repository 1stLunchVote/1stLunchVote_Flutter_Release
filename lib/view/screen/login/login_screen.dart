import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:lunch_vote/controller/login_controller.dart';
import 'package:lunch_vote/styles.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    ScreenUtil.init(context, designSize: const Size(412, 812));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: GetX<LoginController>(builder: (controller) {
          if (controller.showToast.isNotEmpty) {
            Fluttertoast.showToast(
                msg: controller.showToast, toastLength: Toast.LENGTH_SHORT);
          }

          return Form(
            key: controller.formKey,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Image.asset(
                        "assets/images/lunch_vote_splash.png",
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 50),
                      Column(
                        children: [
                          TextFormField(
                            controller: controller.emailController,
                            decoration: const InputDecoration(labelText: "이메일"),
                            validator: (value) {},
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: controller.emailController,
                            decoration: InputDecoration(
                                labelText: "비밀번호",
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.changePwdVisible();
                                    },
                                    icon: Icon(controller.pwdVisible
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined))),
                            validator: (value) {},
                            // 비밀번호 가리기
                            obscureText: !controller.pwdVisible,
                          ),
                          const SizedBox(height: 12),
                          MaterialButton(
                            onPressed: () {},
                            padding: const EdgeInsets.all(0),
                            minWidth: 0,
                            child: Image.asset(
                              'assets/images/bg_lunch_vote_login.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('계정이 없으신가요?',
                                  style: Theme.of(context).textTheme.bodyLarge),
                              InkWell(
                                onTap: () {
                                  // Todo : 회원 가입 페이지로 넘어가기
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    '회원가입',
                                    style: TextStyle(
                                        color: primary1,
                                        decoration: TextDecoration.underline,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const Spacer(),
                      LoginButtonList(onGoogleLogin: () {
                        controller.googleLogin();
                      }),
                    ],
                  ),
                ),
                Visibility(
                  visible: controller.loginLoading,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey.withOpacity(0.5),
                    alignment: Alignment.center,
                    child: const Center(
                      child: CircularProgressIndicator(color: primary1),
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}

class LoginButtonList extends StatelessWidget {
  final VoidCallback onGoogleLogin;
  const LoginButtonList({Key? key, required this.onGoogleLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 44),
      child: Column(
        children: [
          Image.asset(Theme.of(context).brightness == Brightness.light ?
          'assets/images/login_divider_light.png'
              : 'assets/images/login_divider_dark.png', fit: BoxFit.fill,),
          const SizedBox(height: 20),
          // 구글 로그인으로 변경
          MaterialButton(
              padding: const EdgeInsets.all(0),
              minWidth: 0,
              onPressed: onGoogleLogin,
              child: Image.asset('assets/images/bg_google_login.png', fit: BoxFit.fill,)
          ),
          const SizedBox(height: 20),
          MaterialButton(onPressed: (){},
            padding: const EdgeInsets.all(0),
            minWidth: 0,
            child: Image.asset('assets/images/bg_apple_login.png', fit: BoxFit.fill,),
          )
        ],
      ),
    );
  }
}