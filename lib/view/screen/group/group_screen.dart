import 'package:flutter/material.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/custom_clip_path.dart';

import '../../widget/group_user.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BasicAppbar(
        backVisible: true,
        appbarTitle: "친구 초대하기",
        isTitleCenter: true,
        context: context,
        trailingList: [
          IconButton(
            onPressed: () {
              // TODO: 방 상세 설정화면으로 이동
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => const GroupSettingScreen()));
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
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
            Center(
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
                            userName: '참여자',
                            imgUrl: 'assets/images/profile_default.png',
                            isLeader: true,
                          ),
                        ),
                        const Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 1,
                          child: GroupUser(
                            userName: '참여자',
                            imgUrl: 'assets/images/profile_default.png',
                            isLeader: false,
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
                            userName: '참여자',
                            imgUrl: 'assets/images/profile_default.png',
                            isLeader: false,
                          ),
                        ),
                        const Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 1,
                          child: GroupUser(
                            userName: '참여자',
                            imgUrl: 'assets/images/profile_default.png',
                            isLeader: false,
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
                            userName: '참여자',
                            imgUrl: 'assets/images/profile_default.png',
                            isLeader: false,
                          ),
                        ),
                        const Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 1,
                          child: GroupUser(
                            userName: '참여자',
                            imgUrl: 'assets/images/profile_default.png',
                            isLeader: false,
                          ),
                        ),
                        const Expanded(flex: 1, child: SizedBox()),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){},
                    child: const Text("투표 시작!"),
                  ),
                  const Expanded(flex: 1, child: SizedBox()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}