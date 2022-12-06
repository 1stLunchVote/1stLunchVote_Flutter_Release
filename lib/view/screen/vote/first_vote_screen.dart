import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/custom_clip_path.dart';
import 'package:lunch_vote/view/widget/first_vote_tile.dart';


class FirstVoteScreen extends StatefulWidget {
  const FirstVoteScreen({Key? key}) : super(key: key);

  @override
  State<FirstVoteScreen> createState() => _FirstVoteScreenState();
}

class _FirstVoteScreenState extends State<FirstVoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        backVisible: false,
        appbarTitle: "투표 1단계 - 선호&비선호",
        isTitleCenter: false,
        context: context,
        trailingList: [
          IconButton(
              onPressed: (){

              },
              icon: const Icon(Icons.more_vert)
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              height: double.infinity,
              color: Theme.of(context).colorScheme.surfaceVariant,
            ),
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
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                        width: 320.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.search),
                              SizedBox(width: 16.w,),
                              Text('메뉴를 검색해주세요.'),
                            ],
                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                        width: 320.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(width: 16.w,),
                              Text('템플릿을 선택해주세요.'),
                              SizedBox(width: 120.w,),
                              IconButton(
                                icon: Icon(Icons.unfold_more),
                                onPressed: (){
                                  // TODO 템플릿 선택하는 함수 넣어야 함.
                                },
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: 16.h,),

                  FutureBuilder(
                    future: null,
                      builder: (context, snapshot){
                      if(snapshot.hasData == false) {
                        return GridView.builder(
                          itemCount: 50,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1 / 2,
                            mainAxisSpacing: 10.sp,
                            crossAxisSpacing: 10.sp,
                          ),
                          itemBuilder: (BuildContext context, int index){
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FirstVoteTile(
                                  menuName: "음식 ${index + 1}",
                                  imgUrl: null,
                                  index: index,
                                ),
                            );
                          });
                      }
                      //error가 발생하게 될 경우 반환하게 되는 부분
                      else if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        );
                      }
                      // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                      else {
                        // Todo : 아이템 만들기
                        return GridView.builder(
                            itemCount: 50,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1 / 2,
                              mainAxisSpacing: 10.sp,
                              crossAxisSpacing: 10.sp,
                            ),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                const EdgeInsets.only(bottom: 20),
                                child: GridTile(
                                  child: Text("$index"),
                                ),
                              );
                            },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}