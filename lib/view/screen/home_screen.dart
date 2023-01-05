import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunch_vote/controller/group_controller.dart';
import 'package:lunch_vote/controller/home_controller.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/friend/friendlist_screen.dart';
import 'package:lunch_vote/view/screen/group/group_screen.dart';
import 'package:lunch_vote/model/group_id_notifier.dart';
import 'package:lunch_vote/view/screen/profile_screen.dart';
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

late AndroidNotificationChannel channel;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  showFlutterNotification(message);
}

Future<void> setupFlutterNotifications() async {
  var androidInitialize =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationsSettings =
      InitializationSettings(android: androidInitialize);
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
      body: FutureBuilder(
        future: _controller.getNickname(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          return SafeArea(
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
                            Text(
                              snapshot.data ?? "",
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
                              FloatingActionButton(onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TemplateScreen()));
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
                              FloatingActionButton(onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (
                                        context) => const FriendlistScreen()));
                              },
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
          );
        }
      )
    );
  }
}
