import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/controller/profile_controller.dart';
import 'package:lunch_vote/controller/nickname_controller.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/login_screen.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/awesome_dialog.dart';
import 'package:lunch_vote/view/widget/custom_clip_path.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = ProfileController();
  final nicknameController = Get.put(NicknameController());
  bool _nicknameChange = false;

  final TextEditingController _nickNameEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late Future future;

  @override
  void initState() {
    super.initState();
    future = _profileController.getProfileInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        backVisible: true,
        appbarTitle: "마이페이지",
        isTitleCenter: false,
        context: context,
        onPop: () {
          Navigator.of(context).pop();
        },
      ),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.data == null){
                return const Center(child: CircularProgressIndicator());
              }
              else {
                return Stack(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 56,
                          ),
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(
                                    snapshot.data!.profileImage),
                                  radius: 100,
                                ),
                              ]
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(() =>
                            Text("${nicknameController.nickname} 님",
                                style: Theme.of(context).textTheme.titleLarge)
                        ),
                        Visibility(
                          visible: !_nicknameChange,
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _nicknameChange = !_nicknameChange;
                                });
                              },
                              child: Text(
                                '닉네임 수정',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    decoration: TextDecoration.underline,
                                    color: Theme.of(context).hintColor,
                                ),
                              )),
                        ),
                        Visibility(
                            visible: _nicknameChange,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: TextFormField(
                                controller: _nickNameEditingController,
                                decoration: InputDecoration(
                                    labelText: '닉네임 변경',
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (_nickNameEditingController.text
                                                .isEmpty) {
                                              _nicknameChange = false;
                                            } else {
                                              _nickNameEditingController.text = '';
                                            }
                                          });
                                        },
                                        icon: const Icon(Icons.close)
                                    )
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '닉네임을 입력해주세요.';
                                  } else
                                  if (value.length < 2 || value.length > 8) {
                                    return '닉네임 길이를 2~8로 해주세요.';
                                  }
                                  return null;
                                },
                              ),
                            ))
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _nicknameChange,
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 90),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _profileController
                                  .changeNickname(_nickNameEditingController.text)
                                  .then((value) {
                                String complete = value != null ? '성공' : '실패';
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            '닉네임 변경에 $complete 하였습니다.')));
                                setState(() {
                                  _nicknameChange = false;
                                  // future 재선언 하여 프로필 정보 리로드

                                  future = _profileController.getProfileInfo();
                                  nicknameController.setNickname(_nickNameEditingController.text);
                                });
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primary1,
                              padding: const EdgeInsets.fromLTRB(
                                  24, 10, 24, 10)),
                          child: Text(
                            '설정 완료',
                            style: Theme.of(context).textTheme.button?.copyWith(
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                    Visibility(
                        visible: !_nicknameChange,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 90),
                            child: ElevatedButton(
                              onPressed: () async {
                                bool res = await _showDialog();
                                if (res){
                                  _profileController.logout();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) =>
                                          const LoginScreen()), (route) => false);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primary1,
                                  padding: const EdgeInsets.fromLTRB(24, 10, 24, 10)),
                              child: Text("로그아웃",
                                style:  Theme.of(context).textTheme.button?.copyWith(
                                  color: Colors.white)
                                )
                              )
                            ),
                          ),
                        )
                  ],
              );
            }
            }
          ),
        ),
      ),
    );
  }

  Future<bool> _showDialog() async{
    var res = await LunchAwesomeDialog(
      context: context,
      title: "방 나가기",
      body: "정말로 로그아웃 하시겠습니까?",
      okText: '예',
      cancelText: '아니오',
    ).showDialog();

    return Future.value(res);
  }
}
