import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/controller/nickname_controller.dart';
import 'package:lunch_vote/controller/profile_controller.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/login/login_screen.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/awesome_dialog.dart';
import 'package:lunch_vote/view/widget/custom_clip_path.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nickNameEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        backVisible: true,
        appbarTitle: "마이페이지",
        isTitleCenter: false,
        context: context,
        onPop: () {
          Get.back();
        },
      ),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: GetX<ProfileController>(
            initState: (state){
              state.controller?.getProfileInfo();
            },
            builder: (controller) {
              return controller.profileData == null
                  ? const Center(child: CircularProgressIndicator())
                  : Stack(
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
                            child: Stack(children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                    controller.profileData?.profileImage ?? ""),
                                radius: 100,
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("${controller.nickname} 님",
                              style:
                              Theme
                                  .of(context)
                                  .textTheme
                                  .titleLarge),
                          Visibility(
                            visible: !controller.nicknameChange,
                            child: TextButton(
                                onPressed: () {
                                  controller.setNicknameChange(true);
                                },
                                child: Text(
                                  '닉네임 수정',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                    decoration:
                                    TextDecoration.underline,
                                    color: Theme
                                        .of(context)
                                        .hintColor,
                                  ),
                                )),
                          ),
                          Visibility(
                              visible: controller.nicknameChange,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20, 20, 20, 0),
                                child: TextFormField(
                                  controller: _nickNameEditingController,
                                  decoration: InputDecoration(
                                      labelText: '닉네임 변경',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            if (_nickNameEditingController
                                                .text.isEmpty) {
                                              controller.setNicknameChange(false);
                                            } else {
                                              _nickNameEditingController
                                                  .text = '';
                                            }
                                          },
                                          icon: const Icon(Icons.close))),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '닉네임을 입력해주세요.';
                                    } else if (value.length < 2 ||
                                        value.length > 8) {
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
                      visible: controller.nicknameChange,
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 90),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                controller.changeNickname(
                                    _nickNameEditingController.text);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primary1,
                                padding: const EdgeInsets.fromLTRB(
                                    24, 10, 24, 10)),
                            child: Text(
                              '설정 완료',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .button
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !controller.nicknameChange,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 90),
                            child: ElevatedButton(
                                onPressed: () async {
                                  bool res = await controller.showDialog(context);
                                  if (res) {
                                    controller.logout();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primary1,
                                    padding: const EdgeInsets.fromLTRB(
                                        24, 10, 24, 10)),
                                child: Text("로그아웃",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .button
                                        ?.copyWith(color: Colors.white)))),
                      ),
                    )
                  ],
              );
            }
          ),
        ),
      ),
    );
  }
}
