import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/custom_clip_path.dart';
import 'package:lunch_vote/view/widget/first_vote_tile.dart';
import 'package:lunch_vote/controller/menu_controller.dart';
import 'package:lunch_vote/model/menu/menu_info.dart';

class FirstVoteScreen extends StatefulWidget {
  FirstVoteScreen({Key? key}) : super(key: key);

  @override
  State<FirstVoteScreen> createState() => _FirstVoteScreenState();
}

class _FirstVoteScreenState extends State<FirstVoteScreen> {
  final _controller = MenuController();
  final _textController = TextEditingController();
  String searchMenu = '';
  late Future future;

  List<MenuInfo> menuList = [];

  @override
  void initState() {
    super.initState();
    future = _controller.getMenuInfo();
  }

  @override
  void dispose() {
    // 텍스트에디팅컨트롤러를 제거하고, 등록된 리스너도 제거된다.
    _textController.dispose();
    super.dispose();
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
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
                            searchMenu = '';
                          }
                          else {
                            searchMenu = _textController.text.toString();
                            
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO 템플릿 선택하는 함수 넣어야 함.
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
                              SizedBox(
                                width: 16.w,
                              ),
                              Text('템플릿을 선택해주세요.'),
                              SizedBox(
                                width: 120.w,
                              ),
                              IconButton(
                                icon: Icon(Icons.unfold_more),
                                onPressed: () {
                                  // TODO 템플릿 선택하는 함수 넣어야 함.
                                },
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: future,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                              child: CircularProgressIndicator());
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
                            if(snapshot.data[i].menuName.contains(searchMenu)){
                              menuList.add(snapshot.data[i]);
                              print(menuList[i].menuName);
                            }
                          }
                          return GridView.builder(
                              padding: EdgeInsets.all(8.0),
                              shrinkWrap: true,
                              itemCount: menuList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1 / 1,
                                mainAxisSpacing: 4.sp,
                                crossAxisSpacing: 4.sp,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FirstVoteTile(
                                      menuName: menuList[index].menuName,
                                      menuId: menuList[index].menuId,
                                      imgUrl: menuList[index].image,
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
