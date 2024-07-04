import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget appAnimation(String json, {double? height, double? width, bool? repete}) {
  return Lottie.asset(json, height: height, width: width, repeat: repete);
}