import 'package:app_cashback_soamer/widgets/sized_box.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snackbar_content/flutter_snackbar_content.dart';

void showSnackbarError(BuildContext context, {String? message}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        const Icon(Icons.error, color: Colors.white),
        appSizedBoxWidth(10),
        text(message ?? "Ocorreu um erro", color: Colors.white),
      ],
    ),
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.red,
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

void showSnackbarWarning(BuildContext context, {required String message}) {

  final snackBar = SnackBar(
    content: Row(
      children: [
        const Icon(Icons.warning, color: Colors.white),
        appSizedBoxWidth(10),
        text(message, color: Colors.white),
      ],
    ),
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.orange,
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

void showSnackbarSuccess(BuildContext context, {required String message}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        const Icon(Icons.check_circle, color: Colors.white),
        appSizedBoxWidth(10),
        text(message, color: Colors.white),
      ],
    ),
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.green,
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
