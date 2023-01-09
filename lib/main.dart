import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lunch_vote/model/group_id_notifier.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/home_screen.dart';
import 'package:lunch_vote/view/screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunch_vote/view/screen/profile_screen.dart';
import 'package:lunch_vote/view/screen/vote/second_vote_screen.dart';
import 'package:lunch_vote/view/widget/utils/shared_pref_manager.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

late AndroidNotificationChannel channel;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // showNotification(message);
}

Future<void> main() async {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // await initializeNotification();
  await dotenv.load(fileName: 'assets/config/.env');
  // runApp() 호출 전 Flutter SDK 초기화
  String kakaoNativeAppKey = dotenv.get('kakao_native_app_key');
  print(kakaoNativeAppKey);
  KakaoSdk.init(
    nativeAppKey: kakaoNativeAppKey
  );
  runApp(const MyApp());
}

Future initializeNotification() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

  flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (response){
    // Todo : 그룹 초대 화면으로 넘어가기
    print("payload : ${response.payload}");
    Get.to(() => const ProfileScreen());
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
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

void _handleMessage(RemoteMessage message) {
  Get.to(() => const ProfileScreen());
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _autoLogin = false;
  SharedPrefManager spfManager = SharedPrefManager();

  @override
  void initState() {
    super.initState();
    setAutoLogin();
  }

  void setAutoLogin() async {
    var token = await spfManager.getUserToken();
    if (token == null) {
      setState(() {
        FlutterNativeSplash.remove();
      });
    } else {
      print('User Token : $token');
      setState(() {
        _autoLogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeNotification();
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "제 1회 점심메뉴 총선거",
        theme: lightColorTheme,
        darkTheme: darkColorTheme,
        home: _autoLogin == true ? const HomeScreen() : const LoginScreen());
  }
}
