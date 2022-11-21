import 'dart:ffi';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/home_screen.dart';
import 'package:lunch_vote/view/screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunch_vote/view/widget/utils/shared_pref_manager.dart';
import 'firebase_options.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

void main() async {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
      nativeAppKey: '460927feb9d1b043b37bd492992f62b0',
      javaScriptAppKey: 'c5e7ae17bbb1d4f127300c6c7038c8eb');

  runApp(const MyApp());
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
    setAutoLogin();
    super.initState();
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
