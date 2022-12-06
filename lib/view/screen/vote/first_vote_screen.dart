import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/custom_clip_path.dart';
import 'package:lunch_vote/view/widget/first_vote_tile.dart';
import 'package:lunch_vote/controller/menu_controller.dart';

import '../../../model/menu/menu_info.dart';



class FirstVoteScreen extends StatefulWidget {
  const FirstVoteScreen({Key? key}) : super(key: key);

  @override
  State<FirstVoteScreen> createState() => _FirstVoteScreenState();
}

class _FirstVoteScreenState extends State<FirstVoteScreen> {
  final _controller = MenuController();
  TextEditingController _textController = TextEditingController();
  String searchedMenu = '';
  late Future future;
  late Future afterSearch;
  List<MenuInfo> menuList = [];

  @override
  void initState(){
    super.initState();
    future = _controller.getMenuInfo();
  }

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
                  Container(
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
                  SizedBox(
                    height: 12.h,
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
                  Expanded(
                    child: FutureBuilder(
                      future: future,
                      builder: (context, snapshot){
                        if(snapshot.hasData == false) {
                          return const Center(child: CircularProgressIndicator());
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
                          for(int i=0; i<snapshot.data.length;i++){
                            if(snapshot.data[i].menuName.contains(searchedMenu)){
                              menuList.add(snapshot.data[i]);
                            }
                          }
                          return GridView.builder(
                            shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1 / 1,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                              ),
                              itemBuilder: (BuildContext context, int index){
                                return Container(
                                  child: FirstVoteTile(
                                    menuName: menuList[index].menuName,
                                    menuId: menuList[index].menuId,
                                    image: menuList[index].image,
                                    index: index
                                  ),
                                );
                              });
                        }
                      },
                    ),
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