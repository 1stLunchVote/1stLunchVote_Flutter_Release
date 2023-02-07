import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:lunch_vote/controller/login_controller.dart';
import 'package:lunch_vote/model/login/login_state.dart';
import 'package:lunch_vote/styles.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lunch_vote/view/widget/awesome_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(412, 812));
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: GetX<LoginController>(
          builder: (controller){
            return Stack(
              children : [
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
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: "이메일"
                          ),
                          validator: (value){

                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _pwdController,
                          decoration: InputDecoration(
                            labelText: "비밀번호",
                            suffixIcon: IconButton(onPressed: () {
                              controller.changePwdVisible();
                            }, icon: Icon(controller.pwdVisible ? Icons.visibility_off_outlined :
                            Icons.visibility_outlined))
                          ),
                          validator: (value){

                          },
                          // 비밀번호 가리기
                          obscureText: !controller.pwdVisible,
                        ),
                        const SizedBox(height: 12),
                        MaterialButton(onPressed: () {},
                          padding: const EdgeInsets.all(0),
                          minWidth: 0,
                          child: Image.asset('assets/images/bg_lunch_vote_login.png', fit: BoxFit.fill,),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('계정이 없으신가요?', style: Theme.of(context).textTheme.bodyLarge),
                            InkWell(
                              onTap: (){
                                // Todo : 회원 가입 페이지로 넘어가기
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text('회원가입', style: TextStyle(
                                    color: primary1,
                                    decoration: TextDecoration.underline,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 44),
                      child: Column(
                        children: [
                          Image.asset(Theme.of(context).brightness == Brightness.light ?
                            'assets/images/login_divider_light.png'
                              : 'assets/images/login_divider_dark.png', fit: BoxFit.fill,),
                          const SizedBox(height: 20),
                          MaterialButton(
                              padding: const EdgeInsets.all(0),
                              minWidth: 0,
                              onPressed: () {
                                if (controller.loginState is !LoginLoading){
                                  controller.kakaoLogin();
                                }
                              },
                              child: Image.asset('assets/images/bg_kakao_login.png', fit: BoxFit.fill,)
                          ),
                          const SizedBox(height: 20),
                          MaterialButton(onPressed: (){},
                            padding: const EdgeInsets.all(0),
                            minWidth: 0,
                            child: Image.asset('assets/images/bg_apple_login.png', fit: BoxFit.fill,),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: controller.loginState is LoginLoading,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey.withOpacity(0.5),
                  alignment: Alignment.center,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
             ],
            );
          }
        )
      ),
    );
  }
}
