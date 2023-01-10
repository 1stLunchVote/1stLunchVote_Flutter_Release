// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunch_vote/controller/first_vote_controller.dart';
import 'package:lunch_vote/controller/group_controller.dart';
import 'package:lunch_vote/controller/template_controller.dart';
import 'package:lunch_vote/controller/vote_state_controller.dart';
import 'package:lunch_vote/model/template/all_template_info.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/vote/second_vote_screen.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/awesome_dialog.dart';
import 'package:lunch_vote/view/widget/first_vote_tile.dart';
import 'package:lunch_vote/controller/menu_controller.dart';
import 'package:lunch_vote/view/widget/lunch_button.dart';
import 'package:provider/provider.dart';
import 'package:lunch_vote/model/menu/menu_info.dart';
import 'package:lunch_vote/model/vote/first_vote_notifier.dart';

class FirstVoteScreen extends StatelessWidget {
  final String groupId;

  const FirstVoteScreen({
    super.key,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FirstVoteNotifier(),
      child: FirstVotePage(groupId: groupId),
    );
  }
}

class FirstVotePage extends StatefulWidget {
  final String groupId;
  const FirstVotePage({
    super.key,
    required this.groupId,
  });

  @override
  State<FirstVotePage> createState() => _FirstVotePageState();
}

class _FirstVotePageState extends State<FirstVotePage> {
  final _menuController = MenuController();
  final _firstVoteController = FirstVoteController();
  final _templateController = TemplateController();
  final _voteStateController = VoteStateController();
  final _textController = TextEditingController();
  final _groupController = GroupController();
  String searchedMenu = '';
  late Future future;
  late Future afterSearch;
  List<MenuInfo> menuList = [];
  List<AllTemplateInfo> allTemplateList = [AllTemplateInfo(lunchTemplateId: "", templateName: "선택 안함")];
  bool isMenuLoaded = false;
  bool isAllTemplateLoaded = false;

  Timer? _timer;

  @override
  void initState(){
    super.initState();
    _menuController.getMenuInfo().then((value) {
      setState(() {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            context.read<FirstVoteNotifier>().addList(value[i]);
          }
        }
        isMenuLoaded = true;
      });
    });

    _templateController.getAllTemplateInfo().then((value) {
      setState(() {
        isAllTemplateLoaded = true;
        if (value != null) {
          for (int i = 0; i<value.length; i++) {
            allTemplateList.add(value[i]);
          }
        }
      });
    });
  }

  @override
  void dispose(){
    super.dispose();
    _timer?.cancel();
  }

  bool tipVisibility = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        var res = await LunchAwesomeDialog(
          context: context,
          title: "방 나가기",
          body: "정말로 방을 나가시겠습니까?\n나가시면 투표에 다시 참가할 수 없습니다.",
          okText: "예",
          cancelText: "아니오",
        ).showDialog();
        if (res == true){
          var message = await _groupController.withdrawalUser(widget.groupId);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
        return res;
      },
      child: Scaffold(
        appBar: BasicAppbar(
          backVisible: false,
          appbarTitle: "투표 1단계 - 선호&비선호",
          isTitleCenter: false,
          context: context,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Visibility(
                visible: tipVisibility,
                child: Center(
                  child: Column(
                    children: [
                      const Spacer(),
                      Text('Tips!', style: Theme.of(context).textTheme.headlineMedium,),
                      const SizedBox(height: 20,),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: '한 번 클릭하면 ', style: Theme.of(context).textTheme.bodyLarge,),
                            TextSpan(text: '먹고 싶은 음식', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: positive,),),
                            TextSpan(text: '으로,', style: Theme.of(context).textTheme.bodyLarge,),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: '두 번 클릭하면 ', style: Theme.of(context).textTheme.bodyLarge,),
                            TextSpan(text: '먹고 싶지 않은 음식', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: negative,),),
                            TextSpan(text: '으로,', style: Theme.of(context).textTheme.bodyLarge,),
                          ],
                        ),
                      ),
                      RichText(text: TextSpan(text: '세 번 클릭하면 선택이 해제됩니다!', style: Theme.of(context).textTheme.bodyLarge,),),
                      const Spacer(),
                      LunchButton(
                        context: context,
                        isEnabled: true,
                        enabledText: "투표 시작!",
                        pressedCallback: () {
                          setState(() {
                            tipVisibility = false;
                          });
                        },
                      ),
                      const SizedBox(height: 100,),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: !tipVisibility,
                child: Center(
                  child: ListView(
                    children: [
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '메뉴 검색',
                            hintText: 'ex) 파스타'
                          ),
                          onFieldSubmitted: (value) {
                            context.read<FirstVoteNotifier>().searchMenu(_textController.text.toString());
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: DropdownButtonFormField(
                          key: UniqueKey(),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '템플릿을 선택해주세요.',
                          ),
                          items: allTemplateList.map((value) {
                            return DropdownMenuItem(
                              value: value.lunchTemplateId,
                              child: Text(value.templateName),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() async {
                              if (value == "") {
                                context.read<FirstVoteNotifier>().resetTemplate();
                              } else {
                                var list = await _templateController.getOneTemplateInfo(value!);
                                if (list != null) {
                                  context.read<FirstVoteNotifier>().clearList();
                                  for (int i = 0; i < list.length; i++) {
                                    context.read<FirstVoteNotifier>().addListWithStatus(list[i]);
                                  }
                                }
                              }
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: GridView.builder(
                          cacheExtent: 999999999999999,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: context.read<FirstVoteNotifier>().length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 9/10,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                          ),
                          itemBuilder: (BuildContext context, int index){
                            return FirstVoteTile(menuIdx: index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: context.watch<FirstVoteNotifier>().isLoading,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20,),
                      Text(
                        "다른 참가자들이 투표 중입니다.\n잠시만 기다려주세요...",
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: !tipVisibility,
          child: LunchButton(
            context: context,
            isEnabled: context.watch<FirstVoteNotifier>().visibility,
            enabledText: '선택 완료',
            disabledText: '선택 불가',
            notifyText: '최소 1가지의 아이템을 선택해야 저장할 수 있습니다.',
            pressedCallback: () async{
              _firstVoteController.submitFirstVote(
                  widget.groupId,
                  context.read<FirstVoteNotifier>().getLikeMenu(),
                  context.read<FirstVoteNotifier>().getDislikeMenu()
              );
              context.read<FirstVoteNotifier>().startLoading();
              var temp = await _voteStateController.fetchFirstVoteResult(widget.groupId);

              if (temp != true){
                _timer = Timer.periodic(const Duration(milliseconds: 3000), (timer) async {
                  var temp = await _voteStateController.fetchFirstVoteResult(widget.groupId);
                  if (temp == true){
                    _timer?.cancel();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SecondVoteScreen(groupId: widget.groupId))
                    );
                  }
                });
              } else{
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SecondVoteScreen(groupId: widget.groupId))
                );
              }
            },
          ),
        ),
      ),
    );
  }
}