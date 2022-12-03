import 'package:flutter/material.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class AppStyle {
  static const listColor = <Color>[
    Color(0xFFFFF0F0),
    Color(0xFFE3F3FF),
    Color(0xFFF8F4EE),
    Color(0xFFFFF0F0),
    Color(0xFFE3F3FF),
    Color(0xFFF8F4EE),
  ];

  static Color chartColor = const Color(0xFFFFFBF3);
  static Color titleColor = const Color(0xFF16224A);
  static TextStyle headLine = const TextStyle(
      color: Color(0xFF16224A), fontSize: 35, fontWeight: FontWeight.bold);
  static TextStyle bodyText =
      const TextStyle(color: Color(0xFF686E81), fontSize: 16);
  static TextStyle cardHeadline = const TextStyle(
      color: Color(0xFF272727), fontSize: 25, fontWeight: FontWeight.bold);
  static TextStyle cardBody =
      const TextStyle(color: Color(0xFFA8ACB8), fontSize: 16);
  static TextStyle indicatorText = const TextStyle(
      color: Color(0xFF16224A), fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle popUpText =
      const TextStyle(color: Color(0xFF16224A), fontSize: 16);
  static TextStyle timePickText =
      const TextStyle(color: Colors.grey, fontSize: 15);
}
