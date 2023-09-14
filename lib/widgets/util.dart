import 'package:app_cashback_soamer/widgets/custom_clipper.dart';
import 'package:flutter/material.dart';

Widget backgroundCadastroLogin(BuildContext context, {required Widget child, double? height}) {
  return ListView(
    children: [
      Container(
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Colors.grey.shade300,
              Colors.white,
              Colors.grey.shade300,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            SizedBox(height: MediaQuery.of(context).size.height / 5, child: Image.asset("assets/images/logo_soamer.png")),
            ClipPath(
              clipper: CurvaLoginCadastro(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Color.fromRGBO(34, 111, 162, 1)),
                child: child,
              ),
            )
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
          fontFamily: fontFamily ?? 'source',
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
