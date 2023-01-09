import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/widget/friend_tile.dart';
import 'package:lunch_vote/view/widget/lunch_dialog.dart';


class FriendlistScreen extends StatefulWidget {
  const FriendlistScreen({Key? key}) : super(key: key);

  @override
  State<FriendlistScreen> createState() => _FriendlistScreenState();
}

class _FriendlistScreenState extends State<FriendlistScreen> {

  final TextEditingController _emailController = TextEditingController();
  String text = "";

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
        title: Text(
            '친구 관리',
          style: Theme
              .of(context)
              .textTheme
              .titleLarge,
        ),
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
                                  labelText: '이메일',
                                  textButtonText: '취소',
                                  disabledText: '친구 추가',
                                  enabledText: '친구 추가',
                                  notifyText: '이메일을 입력해주세요.',
                                  pressedCallback: () {
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
                SizedBox(height: 24,),
                Expanded(
                    child: ListView.separated(
                      itemCount: 3, // TODO 서버로부터 친구 수 만큼 받아와야 함!
                      itemBuilder: (BuildContext context, int index){
                        return FriendTile();
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(
                        height: 8.0,
                        color: textLightHint,
                      ),
                    )
                ),
              ],
            ),
          ),
        ),

      )
    );
  }
}
