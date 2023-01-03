import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lunch_vote/model/group/group_notifier.dart';
import 'package:lunch_vote/view/screen/vote/first_vote_ready_screen.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/custom_clip_path.dart';
import 'package:lunch_vote/view/widget/group_user.dart';
import 'package:provider/provider.dart';

import 'package:lunch_vote/controller/group_controller.dart';

import '../../../model/group/group_info.dart';

class GroupScreen extends StatelessWidget {
  GroupScreen({Key? key, required this.isLeader, required this.groupId}) : super(key: key);
  final bool isLeader;
  String groupId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GroupNotifier(),
      builder: (context, child) {
        return _GroupScreen(isLeader: isLeader, groupId: groupId,);
      }
    );
  }
}

class _GroupScreen extends StatefulWidget {
  _GroupScreen({Key? key, required this.isLeader, required this.groupId}) : super(key: key);
  final bool isLeader;
  String groupId;

  @override
  State<_GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<_GroupScreen> {
  final GroupController _groupController = GroupController();

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
              content: Text('방 생성에 오류가 발생했습니다.')));
        } else {
          widget.groupId = value;
          context.read<GroupNotifier>().setGroupId(value);
          _groupController.getMyProfile().then((value) {
            if (value != null) {
              context.read<GroupNotifier>().add(MemberInfo(
                email: value.email,
                nickname: value.nickname,
                profileImage: value.profileImage,
              ));
            }
            setState(() {
              isGroupCreated = true;
            });
          });
        }
      });
    } else {
      _groupController.getGroupInfo(widget.groupId).then((value){
        if (value != null) {
          for (int i = 0; i < value.members.length; i++) {
            context.read<GroupNotifier>().add(MemberInfo(
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
      _groupController.getGroupInfo(widget.groupId).then((value){
        if (value != null) {
          context.read<GroupNotifier>().set(value.members);
        }
      });
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
        var res = await _showDialog();
        if (res == true){
          var message = await _groupController.withdrawalUser(widget.groupId);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
        return res;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BasicAppbar(
          backVisible: true,
          appbarTitle: "방 생성하기",
          isTitleCenter: true,
          context: context,
          popCallback: () async{
            var res = await _showDialog();
            if (res == true){
              var message = await _groupController.withdrawalUser(widget.groupId);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
            return res;
          },
        ),
        body: SafeArea(
          child: Stack(
            children: [
              ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: double.infinity,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                ),
              ),
              Stack(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                const Expanded(flex: 1, child: SizedBox()),
                                Expanded(
                                  flex: 1,
                                  child: GroupUser(
                                    userIdx: 0,
                                    isLeader: true,
                                    groupController: _groupController,
                                  ),
                                ),
                                const Expanded(flex: 1, child: SizedBox()),
                                Expanded(
                                  flex: 1,
                                  child: GroupUser(
                                    userIdx: 1,
                                    isLeader: false,
                                    groupController: _groupController,
                                  ),
                                ),
                                const Expanded(flex: 1, child: SizedBox()),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                const Expanded(flex: 1, child: SizedBox()),
                                Expanded(
                                  flex: 1,
                                  child: GroupUser(
                                    userIdx: 2,
                                    isLeader: false,
                                    groupController: _groupController,
                                  ),
                                ),
                                const Expanded(flex: 1, child: SizedBox()),
                                Expanded(
                                  flex: 1,
                                  child: GroupUser(
                                    userIdx: 3,
                                    isLeader: false,
                                    groupController: _groupController,
                                  ),
                                ),
                                const Expanded(flex: 1, child: SizedBox()),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                const Expanded(flex: 1, child: SizedBox()),
                                Expanded(
                                  flex: 1,
                                  child: GroupUser(
                                    userIdx: 4,
                                    isLeader: false,
                                    groupController: _groupController,
                                  ),
                                ),
                                const Expanded(flex: 1, child: SizedBox()),
                                Expanded(
                                  flex: 1,
                                  child: GroupUser(
                                    userIdx: 6,
                                    isLeader: false,
                                    groupController: _groupController,
                                  ),
                                ),
                                const Expanded(flex: 1, child: SizedBox()),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: (){
                              _timer?.cancel();
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => FirstVoteReadyScreen(groupId: widget.groupId))
                              );
                            },
                            child: const Text("투표 시작!"),
                          ),
                          const Expanded(flex: 1, child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showDialog() async{
    bool? canExit;
    AwesomeDialog dlg = AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      title: "방 나가기",
      desc: "정말로 방을 나가시겠습니까?",
      dismissOnTouchOutside: true,
      btnCancelOnPress: () => canExit = false,
      btnOkOnPress: () => canExit = true,
      btnOkText: "예",
      btnCancelText: "아니요",
    );
    await dlg.show();
    return Future.value(canExit);
  }
}