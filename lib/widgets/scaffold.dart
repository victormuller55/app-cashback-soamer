import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

Widget scaffold({
  required Widget body,
  required String title,
  bool? hideBackArrow,
  Widget? bottomNavigationBar,
  List<Widget>? actions,
}) {
  return Scaffold(
    extendBody: true,
    backgroundColor: Colors.grey.shade200,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
      title: appText(title.toUpperCase(), bold: true, color: AppColors.white),
      leading: hideBackArrow ?? false ? Container() : null,
      actions: actions != null ? [...actions, const SizedBox(width: 20)] : null,
    ),
    body: body,
    bottomNavigationBar: bottomNavigationBar,
  );
}
