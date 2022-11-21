import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/custom_clip_path.dart';
import 'package:lunch_vote/view/widget/second_vote_tile.dart';

class SecondVoteScreen extends StatefulWidget {
  const SecondVoteScreen({Key? key}) : super(key: key);

  @override
  State<SecondVoteScreen> createState() => _SecondVoteScreenState();
}

class _SecondVoteScreenState extends State<SecondVoteScreen> {
  String _name = '사용자';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              // Todo : future 추가
                              future: null,
                              builder: (context, snapshot) {
                                //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                                if (snapshot.hasData == false) {
                                  return ListView.builder(
                                      itemCount: 20,
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                          child: SecondVoteTile(
                                              foodName: "음식 ${index + 1}",
                                              imgUrl: null)
                                        );
                                      });
                                  // return const CircularProgressIndicator();
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
                                  // Todo : 아이템 만들기
                                  return ListView.builder(
                                      itemCount: 20,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: ListTile(
                                            title: Text("$index"),
                                          ),
                                        );
                                      });
                                }
                              })
                        ],
                      )
                    ],
                  ),
                  ),
              ),
              )
          ],
        ),
      ),
    );
  }
}
