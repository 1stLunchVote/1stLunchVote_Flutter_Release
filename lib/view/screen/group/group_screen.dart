// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/model/group/group_info.dart';
import 'package:lunch_vote/view/screen/vote/first_vote_screen.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/awesome_dialog.dart';
import 'package:lunch_vote/view/widget/group_user.dart';
import 'package:lunch_vote/view/widget/lunch_button.dart';
import 'package:lunch_vote/controller/group_controller.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({Key? key, required this.isLeader, this.groupId}) : super(key: key);
  final bool isLeader;
  final String? groupId;

  @override
  Widget build(BuildContext context) {
    return _GroupScreen(isLeader: isLeader, groupId: groupId,);
  }
}

class _GroupScreen extends StatefulWidget {
  const _GroupScreen({Key? key, required this.isLeader, this.groupId}) : super(key: key);
  final bool isLeader;
  final String? groupId;

  @override
  State<_GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<_GroupScreen> {
  final _groupController = Get.put(GroupController());
  late final String _groupId;
  bool isGroupCreated = false;

  // 3초 타이머
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.isLeader) {
      _groupController.createGroup().then((value) {
        if (value == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('방 생성에 오류가 발생했습니다.'),));
        } else {
          _groupId = value;
          _groupController.setGroupId(value);
          _groupController.getMyProfile().then((value) {
            if (value != null) {
              _groupController.add(MemberInfo(
                email: value.email,
                nickname: value.nickname,
                profileImage: value.profileImage,
              ));
            }
            setState(() {
              isGroupCreated = true;
              _groupController.checkReady();
            });
          });
        }
      });
    } else {
      _groupId = widget.groupId ?? "";
      _groupController.getGroupInfo(_groupId).then((value){
        if (value != null) {
          for (int i = 0; i < value.members.length; i++) {
            _groupController.add(MemberInfo(
              email: value.members[i].email,
              nickname: value.members[i].nickname,
              profileImage: value.members[i].profileImage,
            ));
          }
        }
        setState(() {
          isGroupCreated = true;
        });
      });
    }

    _timer = Timer.periodic(const Duration(milliseconds: 3000), (timer) async {
      _groupController.getGroupInfo(_groupId).then((value){
        if (value != null) {
          _groupController.set(value.members);
        }
      });
      _groupController.checkReady();
    });
  }

  @override
  void dispose(){
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        var res = await LunchAwesomeDialog(
          context: context,
          title: "방 나가기",
          body: "정말로 방을 나가시겠습니까?",
          okText: "예",
          cancelText: "아니오",
        ).showDialog();
        if (res == true){
          var message = await _groupController.withdrawalUser(_groupId);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
        return res;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BasicAppbar(
          backVisible: true,
          appbarTitle: "투표 대기실",
          isTitleCenter: true,
          context: context,
          onPop: () async{
            var res = await LunchAwesomeDialog(
              context: context,
              title: "방 나가기",
              body: "정말로 방을 나가시겠습니까?",
              okText: "예",
              cancelText: "아니오",
            ).showDialog();
            if (res == true){
              var message = await _groupController.withdrawalUser(_groupId);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
            return res;
          },
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Visibility(
                visible: !isGroupCreated,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              Visibility(
                visible: isGroupCreated,
                child: Center(
                  child: Column(
                    children: [
                      const Expanded(flex: 1, child: SizedBox(),),
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.w),
                          child: GridView.builder(
                            itemCount: 6,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Obx(() => GroupUser(
                                userIdx: index,
                                isLeader: index == 0,
                                leaderAuth: widget.isLeader,
                                isReady: (_groupController.members.length < index + 1) ?
                                false :
                                _groupController.members[index].isReady,
                                groupController: _groupController,
                              ));
                            },
                          ),
                        ),
                      ),
                      const Expanded(flex: 1, child: SizedBox(),),
                      widget.isLeader ?
                      Obx(() => LunchButton(
                        context: context,
                        isEnabled: _groupController.isAllReady,
                        enabledText: "투표 시작하기",
                        disabledText: "투표 시작하기",
                        pressedCallback: () {
                          _timer?.cancel();
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FirstVoteScreen(
                                groupId: _groupId,
                              ),
                            ),
                          );
                        },
                        notifyText: "모든 참가자가 준비완료 상태여야 투표를 시작할 수 있습니다.",
                      )) :
                      LunchButton(
                        context: context,
                        isEnabled: true,
                        enabledText: "준비 완료하기",
                        disabledText: "",
                        pressedCallback: () {
                          // TODO: 준비 상태 변경
                        },
                        notifyText: "",
                      ),
                      const Expanded(flex: 1, child: SizedBox(),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}