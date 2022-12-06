import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunch_vote/controller/group_controller.dart';
import 'package:lunch_vote/controller/home_controller.dart';
import 'package:lunch_vote/view/screen/group/group_screen.dart';
import 'package:lunch_vote/model/group_id_notifier.dart';
import 'package:lunch_vote/view/screen/profile_screen.dart';
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

late AndroidNotificationChannel channel;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  showFlutterNotification(message);
}

Future<void> setupFlutterNotifications() async{
  var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationsSettings = InitializationSettings(android: androidInitialize);
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  flutterLocalNotificationsPlugin.initialize(initializationsSettings);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = HomeController();

  @override
  void initState() {
    super.initState();
    initInfo();
  }

  initInfo() async{
    await setupFlutterNotifications();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((message) {
      if (message.data.containsKey('groupId')){
        print(message.data['groupId']);

        context.read<GroupIdNotifier>().setIndex(message.data['groupId']);
      }
      showFlutterNotification(message);
    });
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    // });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 800));
    return Consumer<GroupIdNotifier>(
      builder: (BuildContext newContext, notifier, _)
    {
      return Scaffold(
        appBar: BasicAppbar(
          backVisible: false,
          appbarTitle: '제 1회 점심메뉴 총선거',
          isTitleCenter: true,
          context: context,
          trailingList: [
            IconButton(
                icon: Icon(
                  Icons.account_circle,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
                })
          ],
        ),
        body: SafeArea(
          child: SizedBox(
            height: 800.h,
            child: Stack(
              children: [
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ClipPath(
                    clipper: CustomClipPath(),
                    child: Container(
                      width: 360.w,
                      height: 400.h,
                      color: Theme
                          .of(context)
                          .colorScheme
                          .surfaceVariant,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Container(
                        height: 200.h,
                        width: 320.w,
                        decoration: BoxDecoration(
                            color:
                            Theme
                                .of(context)
                                .colorScheme
                                .primaryContainer,
                            borderRadius: BorderRadius.circular(16), //모서리를 둥글게
                            border: Border.all(
                                width: 1,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .outline)),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                              child: Text('투표 방 만들기',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .onPrimaryContainer)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Image.asset(
                                      'assets/images/ic_lunch_vote.png')),
                            ),
                            Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GroupScreen(
                                                    isLeader: true, groupId: "",)));
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 200.h,
                        width: 320.w,
                        decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .background,
                            borderRadius: BorderRadius.circular(16), //모서리를 둥글게
                            border: Border.all(
                                width: 1,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .outline)),
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                            child: Text('템플릿 사전 설정하기',
                                style:
                                Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall),
                          ),
                          Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (
                                                context) => const SecondVoteScreen())
                                    );
                                  },
                                ),
                              ))
                        ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: Visibility(
            visible: context
                .watch<GroupIdNotifier>()
                .groupId
                .isNotEmpty,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: ElevatedButton(
                  onPressed: () async {
                    // Todo : groupId 보내기
                    String groupId = context.read<GroupIdNotifier>().groupId;
                    var res = await _controller.joinGroup(groupId);
                    context.read<GroupIdNotifier>().clearIndex();
                    if (res == true){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => GroupScreen(isLeader: false, groupId: groupId,))
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    child: Text("초대된 그룹 화면으로 넘어가기", style: Theme
                        .of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),
                  ),
                )
            )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }
    );
  }
}
