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
  String email = "";
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
                                  context: context,
                                  titleText: '친구 추가하기',
                                  labelText: '이메일',
                                  okBtnText: '친구 추가',
                                  onSaved: (value) {
                                    email = value!;
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return "이메일을 입력해주세요.";
                                    } else if (value.isEmpty) {
                                      return "이메일을 입력해주세요.";
                                    }
                                    return null;
                                  },
                                  okOnPressed: () {
                                    Navigator.pop(context);
                                    // TODO 서버로 친구 추가 요청 보내는 작업 처리해야 함!
                                  },
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
