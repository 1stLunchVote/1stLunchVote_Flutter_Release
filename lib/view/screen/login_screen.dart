import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('안녕하세요 안녕하세요 테스트',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: double.maxFinite,
                child: ElevatedButton(
                    onPressed: (){
                      print("버튼 눌림");
                    },
                    child: Image.asset(
                      'images/bg_kakao_login.png',
                      width: double.infinity,
                      fit: BoxFit.fitWidth)),
              )
            ],
          ),
        ),
      )
    );
  }
}
