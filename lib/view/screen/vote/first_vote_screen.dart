import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunch_vote/controller/first_vote_controller.dart';
import 'package:lunch_vote/controller/template_controller.dart';
import 'package:lunch_vote/controller/vote_state_controller.dart';
import 'package:lunch_vote/model/template/all_template_info.dart';
import 'package:lunch_vote/view/screen/vote/second_vote_screen.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/custom_clip_path.dart';
import 'package:lunch_vote/view/widget/first_vote_tile.dart';
import 'package:lunch_vote/controller/menu_controller.dart';
import 'package:provider/provider.dart';
import '../../../model/menu/menu_info.dart';
import '../../../model/vote/first_vote_notifier.dart';
import '../../../model/vote/vote_item_notifier.dart';

class FirstVoteScreen extends StatelessWidget {

  String groupId;
  FirstVoteScreen({
    Key? key,
    required this.groupId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FirstVoteNotifier(),
      child: FirstVotePage(groupId: groupId),
    );
  }
}

class FirstVotePage extends StatefulWidget {
  String groupId;
  FirstVotePage({
    Key? key,
    required this.groupId
  }) : super(key: key);

  @override
  State<FirstVotePage> createState() => _FirstVotePageState();
}

class _FirstVotePageState extends State<FirstVotePage> {
  final _menuController = MenuController();
  final _firstVoteController = FirstVoteController();
  final _templateController = TemplateController();
  final _voteStateController = VoteStateController();
  final _textController = TextEditingController();
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

  @override
  Widget build(BuildContext context1) {
    return Scaffold(
      appBar: BasicAppbar(
        backVisible: false,
        appbarTitle: "투표 1단계 - 선호&비선호",
        isTitleCenter: false,
        context: context1,
        trailingList: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.more_vert)
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: context1.watch<FirstVoteNotifier>().visibility,
        child: ElevatedButton(
          onPressed: () async{
            _firstVoteController.submitFirstVote(
                widget.groupId,
                context1.read<FirstVoteNotifier>().getLikeMenu(),
                context1.read<FirstVoteNotifier>().getDislikeMenu()
            );
            context1.read<FirstVoteNotifier>().startLoading();
            var temp = await _voteStateController.fetchFirstVoteResult(widget.groupId);

            if (temp != true){
              _timer = Timer.periodic(const Duration(milliseconds: 3000), (timer) async {
                var temp = await _voteStateController.fetchFirstVoteResult(widget.groupId);
                if (temp == true){
                  _timer?.cancel();
                  Navigator.of(context1).push(
                      MaterialPageRoute(builder: (context) => SecondVoteScreen(groupId: widget.groupId))
                  );
                }
              });
            } else{
              Navigator.of(context1).push(
                  MaterialPageRoute(builder: (context) => SecondVoteScreen(groupId: widget.groupId))
              );
            }
          },
          child: const Text('선택 완료!',),
        ),
      ),
      body: Consumer<FirstVoteNotifier>(
        builder: (BuildContext newContext, notifier, _){
          return SafeArea(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: double.infinity,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                ),
                Center(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 320.w,
                          height: 56.h,
                          child: TextField(
                            controller: _textController,
                            style: const TextStyle(
                                color: Colors.black
                            ),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              labelText: '메뉴 검색',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(161, 63, 36, 1),
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0
                                ),
                              ),
                              hintText: 'ex) 파스타',
                            ),
                            onSubmitted: (text){
                              setState((){
                                if(text == ''){
                                  searchedMenu = '';
                                }
                                else {
                                  searchedMenu = _textController.text.toString();
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                          }
                          ).toList(),
                          onChanged: (value) {
                            setState(() async {
                              if (value == "") {
                                context1.read<FirstVoteNotifier>().resetTemplate();
                              } else {
                                var list = await _templateController.getOneTemplateInfo(value!);
                                if (list != null) {
                                  context1.read<FirstVoteNotifier>().clearList();
                                  for (int i = 0; i < list.length; i++) {
                                    context1.read<FirstVoteNotifier>().addListWithStatus(list[i]);
                                  }
                                }
                              }
                            });
                          },
                          validator: (value) {
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16.h,),
                      Stack(
                        children: [
                          Visibility(
                            visible: !isMenuLoaded,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          Visibility(
                            visible: isMenuLoaded,
                            child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              cacheExtent: 999999999999999,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: context1.watch<FirstVoteNotifier>().length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1 / 1,
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
                    ],
                  ),
                ),
                Visibility(
                  visible: context1.watch<FirstVoteNotifier>().isLoading,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context1).colorScheme.surfaceVariant,
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
          );
        }
      ),
    );
  }
}