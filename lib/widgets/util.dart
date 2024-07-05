import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart' as cashboost;
import 'package:flutter/material.dart';
import 'package:muller_package/muller_package.dart';



Widget backgroundCadastroLogin(
    BuildContext context, {
      required Widget child,
      double? height,
    }) {
  return ListView(
    children: [
      Container(
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              cashboost.AppColors.primaryColor,
              cashboost.AppColors.secondaryColor,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 40),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Image.asset("assets/images/logo.png"),
            ),
            child,
          ],
        ),
      ),
    ],
  );
}

Widget infoColumn({
  required String title,
  required String value,
  CrossAxisAlignment? crossAxisAlignment,
  Color? titleColor,
  Color? valueColor,
  double? titleSize,
  double? valueSize,
  double? width,
  bool? spacing,
  bool? ovewflowValue,
  bool? cortarTitle,
  bool? cortarValue,
}) {
  return Builder(builder: (context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: [
          appText(title, bold: true, color: titleColor ?? Colors.white, fontSize: titleSize ?? 15, cortado: cortarTitle),
          SizedBox(height: spacing ?? false ? 5 : 0),
          appText(value, color: valueColor ?? Colors.white, overflow: ovewflowValue ?? true, fontSize: valueSize, cortado: cortarValue),
        ],
      ),
    );
  });
}