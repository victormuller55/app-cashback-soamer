import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:flutter/material.dart';

Widget backgroundCadastroLogin(BuildContext context, {required Widget child, double? height}) {
  return ListView(
    children: [
      Container(
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.primaryColor,
              AppColor.secondaryColor,
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

Widget text(
  String text, {
  Color? color,
  double? fontSize,
  bool? overflow,
  bool? bold,
  double? letterSpacing,
  String? fontFamily,
  TextAlign? textAlign,
  bool? cortado,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Text(
        text,
        textAlign: textAlign ?? TextAlign.start,
        style: TextStyle(
          color: color,
          fontSize: fontSize ?? 15,
          overflow: overflow == true ? TextOverflow.ellipsis : null,
          fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
          letterSpacing: letterSpacing,
          fontFamily: fontFamily ?? 'lato',
          decoration: cortado ?? false ? TextDecoration.lineThrough : null,
        ),
      );
    },
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
}) {
  return Builder(builder: (context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: [
          text(title, bold: true, color: titleColor ?? Colors.white, fontSize: titleSize ?? 20),
          SizedBox(height: spacing ?? false ? 5 : 0),
          text(value, color: valueColor ?? Colors.white, overflow: true, fontSize: valueSize),
        ],
      ),
    );
  });
}
