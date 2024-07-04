import 'package:flutter/cupertino.dart';

bool verificaCampoFormVazio({required List<TextEditingController> controllers}) {
  for (TextEditingController value in controllers) {
    return value.text.isNotEmpty;
  }
  return false;
}
