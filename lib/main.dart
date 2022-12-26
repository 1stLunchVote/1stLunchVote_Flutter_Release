import 'dart:ffi';

import 'package:flutter/scheduler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lunch_vote/model/group_id_notifier.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/home_screen.dart';
import 'package:lunch_vote/view/screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunch_vote/view/screen/vote/second_vote_screen.dart';
import 'package:lunch_vote/view/widget/utils/shared_pref_manager.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

Future<void> main() async {
  final SharedPrefManager _spfManager = SharedPrefManager();
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '460927feb9d1b043b37bd492992f62b0',
    javaScriptAppKey: 'c5e7ae17bbb1d4f127300c6c7038c8eb',
  );

  String? token = await FirebaseMessaging.instance.getToken();
  _spfManager.setFCMToken(token);

  await FirebaseMessaging.instance.getInitialMessage();

  print("FCM Token : $token");

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: mainBackgroundColor
  ));

  runApp(ChangeNotifierProvider(
    create: (context) => GroupIdNotifier(),
    child: const MyApp(),
  ));
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
        FlutterNativeSplash.remove();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GroupIdNotifier(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "1st Lunch Vote",
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'NanumSquareNeo',
            colorScheme: ColorScheme.fromSeed(
                seedColor: mainColor, brightness: Brightness.light),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            fontFamily: 'NanumSquareNeo',
            colorScheme: ColorScheme.fromSeed(
                seedColor: mainColor, brightness: Brightness.dark),
          ),
          home: _autoLogin == true ? const HomeScreen() : const LoginScreen()),
    );
  }
}
