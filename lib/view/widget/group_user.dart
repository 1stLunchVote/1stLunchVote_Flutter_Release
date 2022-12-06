import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunch_vote/model/group/group_notifier.dart';
import 'package:provider/provider.dart';

class GroupUser extends StatefulWidget {
  final int userIdx;
  final bool isLeader;

  const GroupUser({super.key,
    required this.userIdx,
    required this.isLeader,
  });

  @override
  State<GroupUser> createState() => _GroupUserState();
}

class _GroupUserState extends State<GroupUser> {
  @override
  Widget build(BuildContext context) {
    if (context.watch<GroupNotifier>().length < widget.userIdx + 1) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80.w,
            height: 80.h,
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: const AssetImage('assets/images/profile_default.png'),
                  radius: 40.w,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(40),
                    onTap: () {
                      // TODO: 유저 추방 기능
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              context.watch<GroupNotifier>().getMemberNickname(widget.userIdx),
              style: Theme
                  .of(context)
                  .textTheme
                  .labelLarge,
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80.w,
            height: 80.h,
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(context.watch<GroupNotifier>().getMemberProfileImage(widget.userIdx)),
                  radius: 40.w,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(40),
                    onTap: () {
                      // TODO: 유저 추방 기능
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              context.watch<GroupNotifier>().getMemberNickname(widget.userIdx),
              style: Theme
                  .of(context)
                  .textTheme
                  .labelLarge,
            ),
          ),
        ],
      );
    }
  }
}