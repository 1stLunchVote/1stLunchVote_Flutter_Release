import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lunch_vote/controller/notification_controller.dart';
import 'package:lunch_vote/provider/lunch_vote_dio_provider.dart';
import 'package:lunch_vote/routes/app_pages.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/utils/shared_pref_manager.dart';
import 'package:lunch_vote/view/screen/group/group_screen.dart';
import 'package:lunch_vote/view/screen/home_screen.dart';
import 'package:lunch_vote/view/screen/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

late AndroidNotificationChannel channel;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final NotificationController notificationController = Get.put(NotificationController());
final SharedPrefManager spfManager = SharedPrefManager();

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('background 호출됨');
}

Future<void> main() async {

  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // 세로모드 고정
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // await initializeNotification();
  // runApp() 호출 전 Flutter SDK 초기화
  String? token = await spfManager.getUserToken();
  if(token != null){
    LunchVoteDioProvider.setOptions(token);
  }

  runApp(const MyApp());
}

Future initializeNotification() async{

  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  print('FCM Token : ${await messaging.getToken()}');

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 로컬 알림 플러그인

  // IOS 권한 체크
  if (Platform.isIOS){
    await requestPermission(messaging);
  }


  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/launcher_icon'
  );

  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (response) async {
    var groupId = await spfManager.getGroupId();
    print("response groupId : $groupId");
    if(groupId != null){
      notificationController.joinGroup(groupId).then((value) {
        Get.to(() => GroupScreen(), arguments: {'groupId': groupId});
        spfManager.clearGroupId();
      }
      );
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("message : $message");
      // Todo : 친구 초대 알림이 온 경우 따로 빼기
      if (message.data.containsKey('groupId')) {
        spfManager.setGroupId(message.data['groupId']);
      }
        // if (message.data.containsKey('groupId')){
      //   notificationController.setGroupId(message.data['groupId']);
      // }
      showNotification(message);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  // FCM Token Refresh
  messaging.onTokenRefresh.listen((fcmToken) {
    // TODO: If necessary send token to application server.

  }).onError((err){
    print(err);
  });
}

void showNotification(RemoteMessage message) async{
  // Android channel 설정
  channel = const AndroidNotificationChannel(
    'lunch_vote_channel', // id
    'High Importance Notifications', // name
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/launcher_icon',
          ),
          iOS: const DarwinNotificationDetails(
            badgeNumber: 1,
            subtitle: 'the subtitle',
            sound: 'slow_spring_board.aiff',
          )));
}

Future requestPermission(FirebaseMessaging messaging) async{
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

void _handleMessage(RemoteMessage message) async{
  if (message.data.containsKey('groupId')){
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('groupId', message.data['groupId']);
    var groupId = message.data['groupId'];
    notificationController.joinGroup(groupId).then((value) {
      if (value != null){
        Get.to(() => GroupScreen(), arguments: {'groupId': groupId});
        spfManager.clearGroupId();
      }
    });
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    initializeNotification();
    final firebaseAuth = FirebaseAuth.instance;
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "제 1회 점심메뉴 총선거",
        theme: lightColorTheme,
        darkTheme: darkColorTheme,
        getPages: AppPages.pages,
        initialRoute: firebaseAuth.currentUser == null ? Routes.login : Routes.home);
  }
}
