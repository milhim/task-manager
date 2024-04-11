// ignore_for_file: deprecated_member_use

import 'dart:math' as math;

import 'package:flutter/material.dart';

class AppColors {
  static ColorScheme colorScheme = ColorScheme(
    primary: blue.shade300,
    secondary: blue.shade100,
    surface: grey,
    background: grey,
    error: Colors.red,
    onPrimary: const Color(0xffffffff),
    onSecondary: const Color(0xffffffff),
    onSurface: const Color(0xff000000),
    onBackground: grey,
    onError: Colors.red,
    brightness: Brightness.light,
  );

  static LinearGradient flipGradient({required bool isRight}) {
    double radian = 238 * 2 * math.pi / 360;
    return LinearGradient(
      colors: isRight ? [blue.shade600, blue.shade200] : [blue.shade200, blue.shade600],
      transform: GradientRotation(radian),
    );
  }

  static LinearGradient homeCardGradient({double angle = 137}) {
    angle = 360 - angle;
    return LinearGradient(colors: [grey.shade50, grey.shade100], transform: GradientRotation(angle * 2 * math.pi / 360));
  }

  static const MaterialColor purple = MaterialColor(
    0xFF9589D7,
    <int, Color>{
      900: Color(0xFF9589D7),
    },
  );
  static const MaterialColor pink = MaterialColor(
    0xFFE03893,
    <int, Color>{
      900: Color(0xFFE03893),
    },
  );

  static const MaterialColor black = MaterialColor(
    0xFF4F4F4F,
    <int, Color>{
      900: Color(0xFF4F4F4F),
    },
  );

  static const MaterialColor grey = MaterialColor(
    0xFFC0DBEA,
    <int, Color>{
      900: Color(0xFFC0DBEA),
    },
  );

  static const MaterialColor blue = MaterialColor(
    0xFF0F6EAB,
    <int, Color>{
      50: Color(0xFF0F6EAB),
      75: Color(0xFF0F6EAB),
      100: Color(0xFF0F6EAB),
      200: Color(0xFF0F6EAB),
      300: Color(0xFF0F6EAB),
      400: Color(0xFF0F6EAB),
      500: Color(0xFF0F6EAB),
      600: Color(0xFF0F6EAB),
      700: Color(0xFF0F6EAB),
      800: Color(0xFF0F6EAB),
      900: Color(0xFF0F6EAB),
    },
  );
}
