import 'package:flutter/material.dart';

void open(BuildContext context, {required Widget screen, bool? closePrevious}) {
  if (closePrevious ?? false) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen));
  } else {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
