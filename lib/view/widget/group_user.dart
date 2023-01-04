// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunch_vote/controller/group_controller.dart';
import 'package:lunch_vote/model/group/group_notifier.dart';
import 'package:lunch_vote/styles.dart';
import 'package:provider/provider.dart';

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
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100.w,
          height: 100.w,
          child: Stack(
            children: [
              (context.watch<GroupNotifier>().length < widget.userIdx + 1) ?
              CircleAvatar(
                backgroundColor: backgroundLight3,
                radius: 50.w,
                child: const Icon(Icons.add, color: textLightSecondary, size: 40,),
              ) :
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(context.watch<GroupNotifier>().members[widget.userIdx].memberInfo.profileImage),
                radius: 50.w,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Theme.of(context).backgroundColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(50.w),
                  onTap: () {
                    if (widget.leaderAuth) {
                      if (context.watch<GroupNotifier>().length < widget.userIdx + 1) {
                        // TODO: 유저 초대 화면
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
                  child: Image.asset('assets/images/ic_group_leader_crown.png'),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            (context.watch<GroupNotifier>().length < widget.userIdx + 1) ?
            '참가자 없음' :
            context.watch<GroupNotifier>().members[widget.userIdx].memberInfo.nickname,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}