import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/controller/second_vote_controller.dart';
import 'package:lunch_vote/model/vote/second_vote_state.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/lunch_button.dart';
import 'package:lunch_vote/view/widget/second_vote_tile.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../routes/app_pages.dart';
import '../../widget/awesome_dialog.dart';

class SecondVoteScreen extends StatelessWidget {
  const SecondVoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          var res = await _showDialog(context);
          if (res == true) {
            Get.offAllNamed(Routes.home);
          }
          return res;
        },
        child: GetX<SecondVoteController>(initState: (state) {
          // arguments가 하나인 경우
          state.controller?.getFirstVoteInfo(Get.arguments);
        }, builder: (controller) {
          return Scaffold(
            appBar: BasicAppbar(
              backVisible: false,
              appbarTitle: "2차 투표",
              isTitleCenter: true,
              context: context,
            ),
            body: controller.voteCompleted == false
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularStepProgressIndicator(
                                  totalSteps: 60,
                                  currentStep: 60 - controller.timeCount,
                                  stepSize: 8,
                                  selectedColor: Colors.transparent,
                                  unselectedColor: primary1,
                                  padding: 0,
                                  width: 88.w,
                                  height: 88.h,
                                  selectedStepSize: 8,
                                  roundedCap: (_, __) => true,
                                ),
                                Center(
                                  child: controller.timeCount <= 10
                                      ? Text('${controller.timeCount}',
                                          textScaleFactor: 1.0,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 30,
                                              color: negative))
                                      : Text('${controller.timeCount}',
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 30,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? textLightSecondary
                                                  : textDarkSecondary)),
                                )
                              ],
                            ),
                            SizedBox(width: 28.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StepProgressIndicator(
                                  totalSteps: 6,
                                  currentStep: 2,
                                  padding: 6.w,
                                  roundedEdges: const Radius.circular(4),
                                  fallbackLength: 256.w,
                                  size: 12.h,
                                  selectedColor: primary1,
                                  unselectedColor:
                                      Theme.of(context).brightness ==
                                              Brightness.light
                                          ? textLightHint
                                          : textDarkHint,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text("현재 ",
                                        textScaleFactor: 1.0,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? textLightSecondary
                                                    : textDarkSecondary)),
                                    Text(
                                      "2",
                                      textScaleFactor: 1.0,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: primary1),
                                    ),
                                    Text("명이 투표를 완료했습니다! ",
                                        textScaleFactor: 1.0,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? textLightSecondary
                                                    : textDarkSecondary)),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Container(
                            width: Get.size.width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? textLightSecondary
                                        : textDarkSecondary,
                                    width: 1.0),
                                color: Theme.of(context).colorScheme.background,
                                boxShadow: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 4,
                                          offset: const Offset(4,
                                              -4), // changes position of shadow
                                        ),
                                      ]
                                    : []),
                            child: CustomScrollView(
                              slivers: [
                                SliverFillRemaining(
                                  child: ListView(
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              controller
                                                  .nicknameController.nickname,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium
                                                  ?.copyWith(color: primary1)),
                                          Text(" 님의 투표",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),

                                      // 투표 용지
                                      if (controller.voteItems.isEmpty) ...[
                                        const Center(
                                            child: CircularProgressIndicator())
                                      ] else ...[
                                        ListView.builder(
                                            itemCount: controller.voteItems.length,
                                            shrinkWrap: true,
                                            physics: const ClampingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                                  child: SecondVoteTile(
                                                    foodName: controller.voteItems[index].menuName,
                                                    imgUrl: controller.voteItems[index].image,
                                                    index: index,
                                                    menuId: controller.voteItems[index].menuId,
                                                    onVote: (menuId) =>
                                                        controller.setVotedId(menuId),
                                                    clearVote: () => controller.clearVotedId(),
                                                    isVoted: (menuId) =>
                                                        controller.checkVoted(menuId),
                                                  ));
                                            })
                                      ]
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('다른 참가자 대기중...',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(
                        height: 48,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularStepProgressIndicator(
                            totalSteps: 60,
                            currentStep: 60 - controller.timeCount,
                            stepSize: 8,
                            selectedColor: Colors.transparent,
                            unselectedColor: primary1,
                            padding: 0,
                            width: 88.w,
                            height: 88.h,
                            selectedStepSize: 8,
                            roundedCap: (_, __) => true,
                          ),
                          Center(
                            child: controller.timeCount <= 10
                                ? Text('${controller.timeCount}',
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 30,
                                        color: negative))
                                : Text('${controller.timeCount}',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 30,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? textLightSecondary
                                            : textDarkSecondary)),
                          )
                        ],
                      ),
                      const SizedBox(height: 28),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 66.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            StepProgressIndicator(
                              totalSteps: 6,
                              currentStep: 2,
                              padding: 6.w,
                              roundedEdges: const Radius.circular(4),
                              fallbackLength: 240.w,
                              size: 12.h,
                              selectedColor: primary1,
                              unselectedColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? textLightHint
                                  : textDarkHint,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("현재 ",
                                    textScaleFactor: 1.0,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? textLightSecondary
                                                    : textDarkSecondary)),
                                Text(
                                  "2",
                                  textScaleFactor: 1.0,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: primary1),
                                ),
                                Text("명이 투표를 완료했습니다! ",
                                    textScaleFactor: 1.0,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? textLightSecondary
                                                    : textDarkSecondary)),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: Visibility(
              visible: !controller.voteCompleted,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 60),
                child: LunchButton(
                  enabledText: "선택 완료",
                  context: context,
                  isEnabled: controller.selectedId.isNotEmpty,
                  disabledText: '선택 대기',
                  pressedCallback: () {
                    controller.voteItem();
                  },
                  notifyText: "최소 1가지의 아이템을 투표해야 합니다.",
                ),
              ),
            ),
          );
        }));
  }

  Future<bool> _showDialog(BuildContext context) async {
    var res = await LunchAwesomeDialog(
      context: context,
      title: "투표 종료",
      body: "정말로 투표를 종료하시겠습니까? 투표가 모두 종료됩니다.",
      okText: '예',
      cancelText: '아니오',
    ).showDialog();
    return Future.value(res);
  }
}

_secondVotePaper(SecondVoteController controller) {

}
