import 'package:flutter/material.dart';
import 'package:muller_package/muller_package.dart';

Widget loadingCircular() {
  return SizedBox(
    height: 60,
    width: 60,
    child: CircularProgressIndicator(color: AppColors.white),
  );
}