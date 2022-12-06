import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunch_vote/controller/group_controller.dart';
import 'package:lunch_vote/view/screen/group/group_screen.dart';
import 'package:lunch_vote/view/screen/profile_screen.dart';
import 'package:lunch_vote/view/screen/vote/first_vote_ready_screen.dart';
import 'package:lunch_vote/view/screen/vote/second_vote_screen.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/custom_clip_path.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 800));
    return Scaffold(
        appBar: BasicAppbar(
          backVisible: false,
          appbarTitle: '제 1회 점심메뉴 총선거',
          isTitleCenter: true,
          context: context,
          trailingList: [
            IconButton(
                icon: Icon(
                  Icons.account_circle,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
                })
          ],
        ),
        body: SafeArea(
          child: SizedBox(
            height: 800.h,
            child: Stack(
              children: [
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ClipPath(
                    clipper: CustomClipPath(),
                    child: Container(
                      width: 360.w,
                      height: 400.h,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Container(
                        height: 200.h,
                        width: 320.w,
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(16), //모서리를 둥글게
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).colorScheme.outline)),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                              child: Text('투표 방 만들기',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Image.asset(
                                      'assets/images/ic_lunch_vote.png')),
                            ),
                            Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => const GroupScreen(isLeader: true,)));
                                },
                              ),
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 200.h,
                        width: 320.w,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(16), //모서리를 둥글게
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).colorScheme.outline)),
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                            child: Text('템플릿 사전 설정하기',
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                          ),
                          Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    // Todo : 임시로 최종 투표 화면으로 가게 함 (테스트 용)
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => const SecondVoteScreen()));
                                  },
                                ),
                              )
                          )
                        ]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
