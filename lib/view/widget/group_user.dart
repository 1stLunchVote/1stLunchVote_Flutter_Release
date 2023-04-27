// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/controller/group_controller.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/widget/lunch_dialog.dart';

class GroupUser extends StatefulWidget {
  final int userIdx;
  final bool isLeader;
  final bool leaderAuth;
  final bool isReady;
  final GroupController groupController;

  const GroupUser({super.key,
    required this.userIdx,
    required this.isLeader,
    this.leaderAuth = false,
    required this.isReady,
    required this.groupController,
  });

  @override
  State<GroupUser> createState() => _GroupUserState();
}

class _GroupUserState extends State<GroupUser> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100.w,
          height: 100.w,
          child: Obx(() => Stack(
            children: [
              (widget.groupController.members.length < widget.userIdx + 1) ?
              CircleAvatar(
                backgroundColor: backgroundLight3,
                radius: 50.w,
                child: const Icon(Icons.add, color: textLightSecondary, size: 40,),
              ) :
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(widget.groupController.members[widget.userIdx].memberInfo.profileImage),
                radius: 50.w,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Theme.of(context).backgroundColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(50.w),
                  onTap: () {
                    if (widget.leaderAuth) {
                      if (widget.groupController.members.length < widget.userIdx + 1) {
                        // TODO: 유저 초대 화면, 현재는 임시적으로 다이얼로그로 초대
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            var email = "";
                            return LunchDialog(
                              context: context,
                              titleText: '친구 초대하기',
                              labelText: '이메일',
                              okBtnText: '초대하기',
                              removable: true,
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
                              okOnPressed: () async {
                                var message = await widget.groupController.inviteUser(email);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      } else {
                        // TODO: 유저 추방 기능
                      }
                    }
                  },
                ),
              ),
              Visibility(
                visible: widget.isLeader,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset('assets/images/ic_group_leader_crown.png', width: 40,),
                ),
              ),
            ],
          )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            (widget.groupController.members.length < widget.userIdx + 1) ?
            '참가자 없음' :
            widget.groupController.members[widget.userIdx].memberInfo.nickname,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}