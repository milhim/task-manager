import 'dart:developer';

import 'package:flutter/material.dart';

Color hexToColor(String code) {
  String hexWithoutHash = code.substring(1);
  Color myColor = Color(int.parse(hexWithoutHash, radix: 16) + 0xFF000000);
  return myColor;
}
