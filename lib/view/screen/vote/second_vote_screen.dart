import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunch_vote/controller/second_vote_controller.dart';
import 'package:lunch_vote/model/vote/vote_item_notifier.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/vote/result_screen.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/custom_clip_path.dart';
import 'package:lunch_vote/view/widget/second_vote_tile.dart';
import 'package:provider/provider.dart';

class SecondVoteScreen extends StatelessWidget {
  const SecondVoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => VoteItemNotifier(),
        child: const SecondVotePage(),
    );
  }
}

class SecondVotePage extends StatefulWidget {
  const SecondVotePage({Key? key}) : super(key: key);

  @override
  State<SecondVotePage> createState() => _SecondVotePageState();
}

class _SecondVotePageState extends State<SecondVotePage> {
  final _controller = SecondVoteController();
  late Future future;

  // Todo : 임시 그룹 ID
  String groupId = "638de27375404f13e7cbf430";

  String _name = '사용자';
  @override
  void initState() {
    super.initState();
    future = _controller.getMenuInfo(groupId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: BasicAppbar(
        backVisible: false,
        appbarTitle: "투표 2단계 - 최종 투표",
        isTitleCenter: false,
        context: context,
        trailingList: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Consumer<VoteItemNotifier>(
        builder: (BuildContext newContext, notifier, _){
          return Stack(
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
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 320.w,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                            width: 1.0
                        ),
                        color: Theme.of(context).colorScheme.background,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 4,
                            offset: const Offset(4, -4), // changes position of shadow
                          ),
                        ]
                    ),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "$_name 님의 투표",
                              style: const TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            FutureBuilder(
                                future: future,
                                builder: (context, snapshot) {
                                  //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                                  if (snapshot.data == null) {
                                    return const Center(child: CircularProgressIndicator());
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
                                  }
                                  // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                                  else {
                                    return ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                              child: SecondVoteTile(
                                                foodName: snapshot.data![index].menuName,
                                                imgUrl: snapshot.data![index].image,
                                                index: index,
                                                menuId: snapshot.data![index].menuId,
                                              )
                                          );
                                        });
                                  }
                                }),
                            Visibility(
                              visible: context.watch<VoteItemNotifier>().menuId.isNotEmpty,
                              child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => const ResultScreen())
                                    );
                                  },
                                  child: const Text("결과화면으로 넘어가기")
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
