import 'package:app_cashback_soamer/app_widget/consts/app_context.dart';
import 'package:flutter/material.dart';

void open({required Widget screen, bool? closePrevious}) {
  if (closePrevious ?? false) {
    Navigator.pushReplacement(AppContext.context, MaterialPageRoute(builder: (context) => screen));
  } else {
    Navigator.push(AppContext.context, MaterialPageRoute(builder: (context) => screen));
  }
}
