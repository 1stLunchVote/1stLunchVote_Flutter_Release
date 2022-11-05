import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lunch_vote/view/screen/profile_screen.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        backVisible: false,
        appbarTitle: '제 1회 점심메뉴 총선거',
        isTitleCenter: true,
        context: context,
        trailingList: [
          IconButton(
              icon: Icon(Icons.account_circle,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen())
                );
              }
            )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.network('https://my-hooni.s3.ap-northeast-2.amazonaws.com/%EA%B0%9C%EB%B0%9C%EC%9E%90+%EC%A7%A4.jpeg')
            ],
          )
          ),

        ),
      );
  }
}
