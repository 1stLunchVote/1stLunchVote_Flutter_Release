import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/controller/profile_controller.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
      body: SafeArea(
        child: GetX<ProfileController>(
          initState: (state){
            state.controller?.getUserInfo();
          },
          builder: (controller) {
            return controller.nickname.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Form(
                  key: controller.formKey,
                  child: Stack(
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
                                    controller.imageUrl),
                                radius: 100,
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("${controller.nickname} 님",
                              style: Theme.of(context).textTheme.titleLarge
                          ),
                          NicknameChangeField(
                              nicknameChange: controller.nicknameChange,
                              controller: controller.nickNameController,
                              onChangeEditing: () {
                                controller.setNicknameChange();
                              },
                            )
                          ],
                      ),
                    ),
                      NicknameChangeButton(
                        nicknameChange: controller.nicknameChange,
                        onClickBtn: () {
                          controller.onClickComplete();
                        },
                      )
                    ],
              ),
            );
          }
        ),
      ),
    );
  }
}

class NicknameChangeField extends StatelessWidget {
  final bool nicknameChange;
  final TextEditingController controller;
  final VoidCallback onChangeEditing;

  const NicknameChangeField({Key? key,
      required this.nicknameChange,
      required this.controller,
      required this.onChangeEditing
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return nicknameChange ?
    // 닉네임 변경중
    Padding(
      padding: const EdgeInsets.fromLTRB(
          20, 20, 20, 0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: '닉네임 변경',
            suffixIcon: IconButton(
                onPressed: () {
                  if (controller.text.isEmpty) {
                    onChangeEditing();
                  } else {
                    controller.text = '';
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
    ) : TextButton(
        onPressed: onChangeEditing,
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
        )
    );
  }
}

class NicknameChangeButton extends StatelessWidget {
  final bool nicknameChange;
  final VoidCallback onClickBtn;
  const NicknameChangeButton({Key? key, required this.nicknameChange, required this.onClickBtn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: ElevatedButton(
          onPressed: onClickBtn,
          style: ElevatedButton.styleFrom(
              backgroundColor: primary1,
              padding: const EdgeInsets.fromLTRB(
                  24, 10, 24, 10)),
          child: Text(
            nicknameChange ? '설정 완료' : '로그아웃',
            style: Theme.of(context).textTheme.button
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

