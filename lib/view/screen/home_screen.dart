import 'package:flutter/material.dart';
import 'package:lunch_vote/view/screen/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.network('https://my-hooni.s3.ap-northeast-2.amazonaws.com/%EA%B0%9C%EB%B0%9C%EC%9E%90+%EC%A7%A4.jpeg'),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen())
                    );
                  },
                  child: const Text("프로필 화면 넘어가기"))
            ],
          )
          ),

        ),
      );
  }
}
