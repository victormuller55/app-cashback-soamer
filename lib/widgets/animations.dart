import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget animacao(String json, {double? height, double? width}) {
  return Lottie.asset(json, height: height, width: width);
}