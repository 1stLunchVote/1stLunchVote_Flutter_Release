import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screen/group/group_invite_screen.dart';

class GroupUser extends StatefulWidget {
  String userName = '';
  String imgUrl = '';
  bool isLeader = false;
  String groupId = '';

  GroupUser({super.key,
    required this.groupId,
    required this.userName,
    required this.imgUrl,
    required this.isLeader,
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
          width: 80.w,
          height: 80.h,
          child: Stack(
            children: [
              Image.asset(widget.imgUrl, width: 80, height: 80),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GroupInviteScreen(groupId: widget.groupId),));
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            widget.userName,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}