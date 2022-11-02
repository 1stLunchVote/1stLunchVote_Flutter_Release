import 'package:flutter/material.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        backVisible: true,
        appbarTitle: "마이페이지",
        isTitleCenter: true,
        context: context,
      )
    );
  }
}
