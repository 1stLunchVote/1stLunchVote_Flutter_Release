import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunch_vote/model/group/group_notifier.dart';
import 'package:provider/provider.dart';

import '../../controller/group_controller.dart';

class GroupUser extends StatefulWidget {
  final int userIdx;
  final bool isLeader;
  final GroupController groupController;

  const GroupUser({super.key,
    required this.userIdx,
    required this.isLeader,
    required this.groupController,
  });

  @override
  State<GroupUser> createState() => _GroupUserState();
}

class _GroupUserState extends State<GroupUser> {
  final _formKey = GlobalKey<FormState>();
  String email = '';

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
                      // TODO: 유저 초대 기능
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            title: const Text("이메일로 초대"),
                            content: Form(
                              key: _formKey,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                  helperText: '',
                                ),
                                onSaved: (value) {
                                  email = value!;
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return "Please enter an email.";
                                  } else if (value.isEmpty) {
                                    return "Please enter an email";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text("확인"),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                  }
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        }
                      );
                      widget.groupController.inviteUser(context.watch<GroupNotifier>().groupId, email);
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
              style: Theme.of(context).textTheme.labelLarge,
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
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ],
      );
    }
  }
}