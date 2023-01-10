import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/controller/nickname_controller.dart';
import 'package:lunch_vote/controller/second_vote_controller.dart';
import 'package:lunch_vote/controller/vote_state_controller.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/vote/result_screen.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/custom_clip_path.dart';
import 'package:lunch_vote/view/widget/lunch_button.dart';
import 'package:lunch_vote/view/widget/second_vote_tile.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../widget/awesome_dialog.dart';

class SecondVoteScreen extends StatelessWidget {
  final String groupId;
  const SecondVoteScreen({Key? key, required this.groupId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SecondVotePage(groupId: groupId);
  }
}

class SecondVotePage extends StatefulWidget {
  final String groupId;
  const SecondVotePage({Key? key, required this.groupId}) : super(key: key);

  @override
  State<SecondVotePage> createState() => _SecondVotePageState();
}

class _SecondVotePageState extends State<SecondVotePage> {
  final _secondVoteController = Get.put(SecondVoteController());
  // Todo : 닉네임 컨트롤러로 사용자 님의 투표 출력할 지 고민
  final _nicknameController = Get.put(NicknameController());
  final _voteStateController = VoteStateController();
  late Future future;
  
  // 3초 타이머
  Timer? _timer;
  
  // 본인 투표 여부
  bool _voteCompleted = false;

  @override
  void initState() {
    super.initState();
    future = _secondVoteController.getMenuInfo(widget.groupId);
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
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
        return res;
      },
      child: Scaffold(
        appBar: BasicAppbar(
          backVisible: false,
          appbarTitle: "2차 투표",
          isTitleCenter: true,
          context: context,
        ),
        body: Padding(
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
                        currentStep: 15,
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
                        child: Text('45', textScaleFactor: 1.0, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30,
                            color: Theme.of(context).brightness == Brightness.light ? textLightSecondary : textDarkSecondary)),
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
                        unselectedColor: Theme.of(context).brightness == Brightness.light ? textLightHint : textDarkHint,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text("현재 ", textScaleFactor: 1.0, style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).brightness == Brightness.light ? textLightSecondary : textDarkSecondary)
                          ),
                          Text("2", textScaleFactor: 1.0, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: primary1),),
                          Text("명이 투표를 완료했습니다! ", textScaleFactor: 1.0, style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).brightness == Brightness.light ? textLightSecondary : textDarkSecondary)
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).brightness == Brightness.light ? textLightSecondary : textDarkSecondary,
                          width: 1.0),
                      color: Theme.of(context).colorScheme.background,
                      boxShadow:  Theme.of(context).brightness == Brightness.light ? [
                       BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 4,
                          offset:
                              const Offset(4, -4), // changes position of shadow
                        ),
                      ] : []),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_nicknameController.nickname,
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: primary1)),
                              Text(" 님의 투표", style: Theme.of(context).textTheme.headlineMedium)
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          FutureBuilder(
                              future: future,
                              builder: (context, snapshot) {
                                //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                                if (!_voteCompleted && snapshot.data == null) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                //error가 발생하게 될 경우 반환하게 되는 부분
                                else if (snapshot.hasError) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Error: ${snapshot.error}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  );
                                } else if (_voteCompleted) {
                                  return Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      const CircularProgressIndicator(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "다른 참가자들이 투표중입니다.\n잠시만 기다려주세요...",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .outline),
                                      )
                                    ],
                                  ));
                                }
                                // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                                else {
                                  return ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 20, 20),
                                            child: SecondVoteTile(
                                              foodName: snapshot
                                                  .data![index].menuName,
                                              imgUrl:
                                                  snapshot.data![index].image,
                                              index: index,
                                              menuId:
                                                  snapshot.data![index].menuId,
                                              controller: _secondVoteController,
                                            ));
                                      });
                                }
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Obx(() => Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 60),
          child: Visibility(
            visible: !_voteCompleted,
            child: LunchButton(
                enabledText: "선택 완료",
                context: context,
                isEnabled: !_voteCompleted && _secondVoteController.selectedId.isNotEmpty,
                disabledText: '선택 대기',
                pressedCallback: () async{
                  // 투표
                  await _secondVoteController.voteItem();
                  var temp = await _voteStateController
                      .fetchSecondVoteResult(widget.groupId);

                  setState(() {
                    _voteCompleted = true;
                  });

                  if (temp != true){
                    _timer = Timer.periodic( const Duration(milliseconds: 3000), (timer) async {
                      var temp = await _voteStateController.fetchSecondVoteResult(widget.groupId);
                      if (temp == true){
                        _timer?.cancel();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ResultScreen(groupId: widget.groupId))
                        );
                      }
                    });
                  } else{
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ResultScreen(groupId: widget.groupId))
                    );
                  }
                }, notifyText: '최소 1가지의 아이템을 투표해야 합니다.',
            ),
          ),
        ),
      ),
      )
    );
  }
  Future<bool> _showDialog() async{
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
