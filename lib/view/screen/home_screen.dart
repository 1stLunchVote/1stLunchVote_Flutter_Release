import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lunch_vote/controller/group_controller.dart';
import 'package:lunch_vote/controller/home_controller.dart';
import 'package:lunch_vote/controller/nickname_controller.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/friend/friendlist_screen.dart';
import 'package:lunch_vote/view/screen/group/group_screen.dart';
import 'package:lunch_vote/model/group_id_notifier.dart';
import 'package:lunch_vote/view/screen/profile_screen.dart';
import 'package:lunch_vote/view/screen/template/template_list_screen.dart';
import 'package:lunch_vote/view/screen/template/template_screen.dart';
import 'package:lunch_vote/view/screen/vote/first_vote_ready_screen.dart';
import 'package:lunch_vote/view/screen/vote/second_vote_screen.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/custom_clip_path.dart';
import 'package:provider/provider.dart';


import '../../firebase_options.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = HomeController();
  final nicknameController = Get.put(NicknameController());

  @override
  void initState() {
    super.initState();
    _controller.getNickname().then((value) {
        nicknameController.setNickname(value!);
        FlutterNativeSplash.remove();
      },
      onError: (e){
        FlutterNativeSplash.remove();
      }
    );
    initInfo();
  }

  initInfo() async {
    // await setupFlutterNotifications();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // FirebaseMessaging.onMessage.listen((message) {
    //   if (message.data.containsKey('groupId')){
    //     print(message.data['groupId']);
    //
    //     context.read<GroupIdNotifier>().setIndex(message.data['groupId']);
    //   }
    //   showFlutterNotification(message);
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    // });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 800));
    return Scaffold(
      // 앱바 기본 높이 56dp
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 44, 24, 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Obx(() => Text(
                            "${nicknameController.nickname}",
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "님, 환영합니다!",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "저희 앱이 처음이신가요?",
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.large(
                      backgroundColor: primary1,
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) =>
                                GroupScreen(isLeader: true, groupId: ""))
                        );
                      },
                      child: Icon(Icons.add, color: Theme
                          .of(context)
                          .scaffoldBackgroundColor),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '새로운 투표 생성하기',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '버튼을 눌러 새로운 투표를 시작하세요!',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        color: Theme
                            .of(context)
                            .hintColor,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const TemplateListScreen()));
                            },
                            backgroundColor: primary1,
                            heroTag: null,
                            child: Icon(Icons.mode_edit, color: Theme
                                .of(context)
                                .scaffoldBackgroundColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '템플릿 설정',
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          // Todo : 제원이가 만들면 바꿀게 임시로 쓴다~
                          FloatingActionButton(onPressed: () {
                            Get.to(const SecondVotePage(groupId: "63bb9e42bb63c8c408880e9f"));},
                            backgroundColor: secondary1,
                            heroTag: null,
                            child: Icon(Icons.person_outline, color: Theme
                                .of(context)
                                .scaffoldBackgroundColor,),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '친구 관리',
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          FloatingActionButton(onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (
                                    context) => const ProfileScreen()));
                          },
                            heroTag: null,
                            backgroundColor: secondary1,
                            child: Icon(Icons.settings, color: Theme
                                .of(context)
                                .scaffoldBackgroundColor),
                          ),
                          const SizedBox(height: 8),
                          Text('마이페이지',
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall,
                          ),
                        ],
                      ),
                    ],

                  ),
                )
              ],
            ),
          )
      )
    );
  }
}
