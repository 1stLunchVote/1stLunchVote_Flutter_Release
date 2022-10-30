import 'package:flutter/material.dart';
import 'package:lunch_vote/controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 60.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '안녕하세요 로그인 테스트',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            Expanded(
                child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: MaterialButton(
                  onPressed: () async {
                    await _loginController.login();
                  },
                  child: Image.asset(
                    'assets/images/bg_kakao_login.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
