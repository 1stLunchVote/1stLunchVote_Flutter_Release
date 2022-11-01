import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/login_screen.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '460927feb9d1b043b37bd492992f62b0',
    javaScriptAppKey: 'c5e7ae17bbb1d4f127300c6c7038c8eb'
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "1st Lunch Vote",
      theme: ThemeData(
          fontFamily: 'NanumSquareNeo',
          colorScheme: ColorScheme.fromSeed(
              seedColor: mainColor,
              brightness: Brightness.light),
          primaryColor: mainColor),
        darkTheme: ThemeData(
          fontFamily: 'NanumSquareNeo',
          colorScheme: ColorScheme.fromSeed(
              seedColor: mainColor,
            brightness: Brightness.dark
          )
      ),
      home: LoginScreen(),
    );
  }
}
