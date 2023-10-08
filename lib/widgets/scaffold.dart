import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

Widget scaffold({required Widget body, required String title, bool? hideBackArrow}) {
  return Scaffold(
    extendBody: true,
    backgroundColor: Colors.grey.shade200,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: AppColor.primaryColor,
      centerTitle: true,
      title: text(title.toUpperCase(), bold: true),
      leading: hideBackArrow ?? false ? Container() : null,
    ),
    body: body,
  );
}