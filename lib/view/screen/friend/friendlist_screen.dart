import 'package:flutter/material.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/widget/friend_tile.dart';
import 'package:lunch_vote/view/widget/lunch_dialog.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/controller/friends_controller.dart';

class FriendlistScreen extends StatefulWidget {
  const FriendlistScreen({Key? key}) : super(key: key);

  @override
  State<FriendlistScreen> createState() => _FriendlistScreenState();
}

class _FriendlistScreenState extends State<FriendlistScreen> {
  final friendsController = Get.put(FriendsController());

  @override
  void initState() {
    super.initState();
    const FriendTile(name: '', profileImage: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            '친구 관리',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '내 친구 목록',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return LunchDialog(
                                  context: context,
                                  titleText: '친구 추가하기',
                                  labelText: '이메일',
                                  okBtnText: '친구 추가',
                                  onSaved: (value) {
                                    friendsController.setEmail(value!);
                                    friendsController.addFriend(value!);
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return "이메일을 입력해주세요.";
                                    } else if (value.isEmpty) {
                                      return "이메일을 입력해주세요.";
                                    }
                                    return null;
                                  },
                                  okOnPressed: () {
                                    friendsController.test();
                                    Navigator.pop(context);
                                    // TODO 서버로 친구 추가 요청 보내는 작업 처리해야 함!
                                  },
                                );
                              });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Obx(() =>
                    Expanded(
                        child: ListView.separated(
                      itemCount: friendsController
                          .friendList.length, // TODO 서버로부터 친구 수 만큼 받아와야 함!
                      itemBuilder: (BuildContext context, int index) {
                        return FriendTile(
                            name: friendsController.friendList[index],
                            profileImage:
                                "assets/images/friend_profile_default.png");
                        // TODO 서버로부터 이름이랑 이름이랑 사진 받아오기
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        height: 8.0,
                        color: textLightHint,
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
