import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lunch_vote/styles.dart';

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
                                var visibilityBtn = true;
                                return AlertDialog(
                                  titlePadding: EdgeInsets.all(24), //24
                                  contentPadding: EdgeInsets.all(24), // 24 0 24 0
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: primary4, // TODO 색상 하드코딩으로 되어 있음. 고치자!
                                  title: Text("친구 추가하기",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Form(
                                        key: _formKey,
                                        child: TextFormField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(),
                                            labelText: '이메일',
                                            helperText: '',
                                            suffixIcon: IconButton(
                                                onPressed: _emailController.clear,
                                                icon: const Icon(Icons.highlight_remove),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                            style: TextButton.styleFrom(),
                                            child: Text('취소',
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: Theme.of(context).primaryColor,
                                              ),
                                            ),
                                          ),


                                        ],
                                      )
                                    ],
                                  ),
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
