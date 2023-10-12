import 'package:flutter/material.dart';
import 'package:flutter_snackbar_content/flutter_snackbar_content.dart';

void showSnackbarError(BuildContext context, {String? message}) {
  final snackBar = SnackBar(
    elevation: 0,
    width: 300,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: FlutterSnackbarContent(
      messageFontSize: 14,
      message: message ?? 'Ops, ocorreu um erro! Tente novamente',
      contentType: ContentType.failure,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

void showSnackbarWarning(BuildContext context, {required String message}) {
  final snackBar = SnackBar(
    elevation: 0,
    width: 300,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: FlutterSnackbarContent(
      messageFontSize: 14,
      message: message,
      contentType: ContentType.warning,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

void showSnackbarSuccess(BuildContext context, {required String message}) {
  final snackBar = SnackBar(
    elevation: 0,
    width: 300,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: FlutterSnackbarContent(
      messageFontSize: 14,
      message: message,
      contentType: ContentType.success,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
