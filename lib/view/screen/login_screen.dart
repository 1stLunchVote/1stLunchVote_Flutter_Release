import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/home_screen.dart';
import 'package:lunch_vote/controller/login_controller.dart';
import 'package:lunch_vote/view/widget/utils/shared_pref_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SharedPrefManager spfManager = SharedPrefManager();

  final LoginController _loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  bool _pwdVisible = false;


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 800));
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Obx(() => Stack(
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
                            setState(() {
                              _pwdVisible = !_pwdVisible;
                            });
                          }, icon: Icon(_pwdVisible ? Icons.visibility_off_outlined :
                          Icons.visibility_outlined))
                        ),
                        validator: (value){

                        },
                        // 비밀번호 가리기
                        obscureText: !_pwdVisible,
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
                            onPressed: () async {
                              if (!_loginController.isLoading) {
                                _loginController.loginToken().then((value) {
                                  if (value != null) {
                                    _loginController.postUserToken(value).then((token) {
                                      if (token != null) {
                                        spfManager.setUserToken(token);
                                        print('User Token : $token');
                                        navigateToHome();
                                      }
                                    }).onError((error, stackTrace) {

                                    });
                                  }
                                });
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
              visible: _loginController.isLoading,
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
        ),
      ),
      )
    );
  }

  void navigateToHome() {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const HomeScreen())
    );
  }
}
