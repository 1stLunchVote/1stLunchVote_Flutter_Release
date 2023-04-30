import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/controller/group_controller.dart';
import 'package:lunch_vote/model/group/group_info.dart';
import 'package:lunch_vote/view/screen/vote/first_vote_screen.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/awesome_dialog.dart';
import 'package:lunch_vote/view/widget/group_user.dart';
import 'package:lunch_vote/view/widget/lunch_button.dart';

class GroupScreen extends StatefulWidget {
  final String? groupId = Get.arguments?.get['groupId'];

  GroupScreen({ super.key });

  @override
  State<GroupScreen> createState() => GroupScreenState();
}

class GroupScreenState extends State<GroupScreen> {
  late final bool isLeader;
  // 3초 타이머
  Timer? _timer;

  @override
  void dispose(){
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<GroupController>(
      initState: (state) {
        isLeader = widget.groupId == null;
        if (isLeader) {
          state.controller?.createGroup().then((success) {
            if (success) {
              state.controller?.checkReady();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('방 생성에 오류가 발생했습니다.'),));
            }
          });
        } else {
          state.controller?.joinGroup(widget.groupId ?? "").then((success) {
            if (success) {
              state.controller?.checkReady();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('방 생성에 오류가 발생했습니다.'),));
            }
          });
        }

        _timer = Timer.periodic(const Duration(milliseconds: 3000), (timer) async {
          state.controller?.getGroupInfo().then((_) {
            state.controller?.checkReady();
          });
        });
      },
      builder: (controller) {
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
              var message = await controller.withdrawalUser();
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
                  var message = await controller.withdrawalUser();
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
                    visible: !controller.isGroupCreated,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  Visibility(
                    visible: controller.isGroupCreated,
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
                                  return GroupUser(
                                    userIdx: index,
                                    isLeader: index == 0,
                                    leaderAuth: isLeader,
                                    isReady: (controller.members.length < index + 1) ?
                                    false :
                                    controller.members[index].isReady,
                                    groupController: controller,
                                  );
                                },
                              ),
                            ),
                          ),
                          const Expanded(flex: 1, child: SizedBox(),),
                          isLeader ?
                          LunchButton(
                            context: context,
                            isEnabled: controller.isAllReady,
                            enabledText: "투표 시작하기",
                            disabledText: "투표 시작하기",
                            pressedCallback: () {
                              _timer?.cancel();
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FirstVoteScreen(
                                    groupId: controller.groupInfo.groupId,
                                  ),
                                ),
                              );
                            },
                            notifyText: "모든 참가자가 준비완료 상태여야 투표를 시작할 수 있습니다.",
                          ) :
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
      },
    );
  }
}