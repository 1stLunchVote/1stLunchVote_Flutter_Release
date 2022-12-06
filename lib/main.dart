import 'dart:ffi';

import 'package:flutter/scheduler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/home_screen.dart';
import 'package:lunch_vote/view/screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunch_vote/view/screen/vote/second_vote_screen.dart';
import 'package:lunch_vote/view/widget/utils/shared_pref_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  print('Handling a background message ${message.messageId}');
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );



  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
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

Future<void> main() async {
  final SharedPrefManager _spfManager = SharedPrefManager();
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await setupFlutterNotifications();


  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
      nativeAppKey: '460927feb9d1b043b37bd492992f62b0',
      javaScriptAppKey: 'c5e7ae17bbb1d4f127300c6c7038c8eb');

  String? token = await FirebaseMessaging.instance.getToken();
  _spfManager.setFCMToken(token);
  print("FCM Token : $token");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _autoLogin = false;
  String? initialMessage;
  bool _resolved = false;
  SharedPrefManager spfManager = SharedPrefManager();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then((value) => setState(
        () {
          if (value != null){
            _resolved = true;
            initialMessage = value?.data.toString();
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondVoteScreen())
            );
          }
        }
    ));
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp : $message");
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SecondVoteScreen())
      );
    });
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
        FlutterNativeSplash.remove();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "1st Lunch Vote",
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'NanumSquareNeo',
            colorScheme: ColorScheme.fromSeed(
                seedColor: mainColor, brightness: Brightness.light),
            scaffoldBackgroundColor: mainBackgroundColor),
        darkTheme: ThemeData(
            useMaterial3: true,
            fontFamily: 'NanumSquareNeo',
            colorScheme: ColorScheme.fromSeed(
                seedColor: mainColor, brightness: Brightness.dark)),
        home: _autoLogin == true ? const HomeScreen() : const LoginScreen()
    );
  }
}
