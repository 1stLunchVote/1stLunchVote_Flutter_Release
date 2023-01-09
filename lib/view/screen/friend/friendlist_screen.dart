import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/widget/lunch_dialog.dart';


class FriendlistScreen extends StatefulWidget {
  const FriendlistScreen({Key? key}) : super(key: key);

  @override
  State<FriendlistScreen> createState() => _FriendlistScreenState();
}

class _FriendlistScreenState extends State<FriendlistScreen> {

  final TextEditingController _emailController = TextEditingController();
  String email = "";

  final _formKey = GlobalKey<FormState>();

  late Future future;

  @override
  void initState() {
    super.initState();
    //future = _profileController.getProfileInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('친구 목록'),
        centerTitle: false,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24,20,24,100),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('내 친구 목록',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge,
                    ),
                    IconButton(
                        onPressed: (){
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return LunchDialog(
                                    title: '친구 추가하기',
                                    textfield_label_text: '이메일',
                                    disabled_button_text: '취소',
                                    enabled_button_text: '친구 추가'
                                );
                              }
                          );
                        },
                        icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

      )
    );
  }
}
