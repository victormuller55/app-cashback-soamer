import 'package:app_cashback_soamer/app_widget/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromRGBO(34, 111, 162, 1),
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(const AppWidget());
}
