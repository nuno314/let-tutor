import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

AppColor get themeColor => AppColor();

class AppColor {
  static const Color white = Colors.white;
  static const Color primaryColor = Color(0xFF1890ff);
  static const Color primaryColorLight = Color(0xFF43c8f5);
  static const Color cardBackground = Color(0xFFf7f8f8);
  static const Color iconSelected = primaryColor;
  static const Color iconUnselected = Colors.grey;
  static const Color lightGrey = Color(0xFFbebebe);
  static const Color greyDC = Color(0xFFdcdcdc);
  static const Color scaffoldBackgroundColor = Color(0xFFF1F3F7);
  static const Color transparent = Colors.transparent;
  static const Color greyE5 = const Color(0xFFE5E5E5);
  static const Color grey64 = Color.fromARGB(255, 225, 225, 230);
  static const Color greenB7EB8F = const Color(0xffb7eb8f);
  static const Color scaffoldColor = const Color(0xffF7F7F7);

  static const Color inactiveColor = Color(0xFF111111);
  static const Color activeColor = primaryColor;

  static const Color titleMenu = Colors.grey;
  static const Color primaryIcon = Colors.grey;
  static const Color green = Color(0xFF4d9e53);
  static const Color red = Color(0xFFfb4b53);
  static const Color orange = Color(0xFFff9b1a);
  static const Color darkBlue = Color(0xFF002d41);
  static const Color grayAD = const Color(0xFFADADAD);
  static const Color gray8C = const Color(0xFF8C8C8C);

  static const Color yellowFADB14 = const Color(0xfffadb14);
  static const Color bluecee8f0 = const Color(0xffcee8f0);

  //light
  static const Color primaryText = Colors.black;
  static const Color subText = Color(0xFF767676);

  //dart
  static const Color primaryDarkText = Colors.black;
  static const Color subDarkText = Colors.grey;

  static void setLightStatusBar() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  }

  static void setDarkStatusBar() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  }
}
