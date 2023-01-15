import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_color_generator/material_color_generator.dart';


const mainColor = Color(0xFFF67F5E);
const mainBackgroundColor = Color(0xFFFFFBFF);
const textHintColor = Color(0xFF7F7572);
const voteBlackColor = Color(0xFF201A19);

const primary1 = Color(0xFFFF652D);
const primary2 = Color(0xFFFF7E50);
const primary3 = Color(0xFFFFA788);
const primary4 = Color(0xFFFFF4F1);

const secondary1 = Color(0xFF7F82EF);
const secondary2 = Color(0xFFA4A7FF);
const secondary3 = Color(0xFFC9CBFF);
const secondary4 = Color(0xFFE6EDFF);

const positive = Color(0xFF4AA96C);
const negative = Color(0xFFEF3C3C);
const error = Color(0xFFBA1A1A);

const textLightMain = Color(0xFF1A1A1B);
const textLightSecondary = Color(0xFF6E6D73);
const textLightHint = Color(0xFFB3B4BC);

const textDarkMain = Colors.white;
const textDarkSecondary = Color(0xFFCED0D6);
const textDarkHint = Color(0xFF82828C);

const backgroundLight1 = Colors.white;
const backgroundLight2 = Color(0xFFF2F3F7);
const backgroundLight3 = Color(0xFFE5E6EB);

const backgroundDark1 = Color(0xFF1A1A1B);
const backgroundDark2 = Color(0xFF3B3B3C);
const backgroundDark3 = Color(0xFF626263);

TextTheme lightTextTheme = const TextTheme(
  headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w800, color: textLightMain),
  titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: textLightMain),
  titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: textLightMain),
  titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: textLightMain),
  bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: textLightMain),
  bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: textLightMain),
  bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: textLightMain),
);

TextTheme darkTextTheme = const TextTheme(
  headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w800, color: textDarkMain),
  titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: textDarkMain),
  titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: textDarkMain),
  titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: textDarkMain),
  bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: textDarkMain),
  bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: textDarkMain),
  bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: textDarkMain),
);

ThemeData lightColorTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'NanumSquareNeo',
  brightness: Brightness.light,
  textTheme: lightTextTheme,
  backgroundColor: backgroundLight1,
  bottomAppBarColor: backgroundLight1,
  dialogBackgroundColor: backgroundLight2,
  disabledColor: backgroundLight3,
  dividerColor: textLightSecondary,
  errorColor: error,
  hintColor: textLightHint,
  indicatorColor: primary1,
  primaryColor: primary1,
  scaffoldBackgroundColor: backgroundLight1,
  secondaryHeaderColor: primary2,
  splashColor: backgroundLight1,
  toggleableActiveColor: primary1,
  primarySwatch: generateMaterialColor(color: primary1),
  appBarTheme: const AppBarTheme(
    color: backgroundLight1,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
    ),
    surfaceTintColor: Colors.transparent
  ),
  inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder())
);

ThemeData darkColorTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'NanumSquareNeo',
  brightness: Brightness.dark,
  textTheme: darkTextTheme,
  backgroundColor: backgroundDark1,
  bottomAppBarColor: backgroundDark1,
  dialogBackgroundColor: backgroundDark2,
  disabledColor: backgroundDark3,
  dividerColor: textDarkSecondary,
  errorColor: error,
  hintColor: textDarkHint,
  indicatorColor: primary1,
  primaryColor: primary1,
  scaffoldBackgroundColor: backgroundDark1,
  secondaryHeaderColor: primary2,
  splashColor: backgroundDark1,
  toggleableActiveColor: primary1,
  primarySwatch: generateMaterialColor(color: primary1),
  appBarTheme: const AppBarTheme(
    color: backgroundDark1,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark
    ),
    surfaceTintColor: Colors.transparent
  ),
  inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder())
);