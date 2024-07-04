import 'package:app_cashback_soamer/app_widget/app_consts/app_font_sizes.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

Widget elevatedButtonPadrao(Widget child, {required void Function() function, Color? backgroundColor, double? width, double? height, double? borderRadius}) {
  return ElevatedButton(
    onPressed: function,
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: backgroundColor ?? Colors.white,
      fixedSize: Size(width ?? 300, height ?? 50),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: backgroundColor ?? Colors.white),
        borderRadius: BorderRadius.circular(borderRadius ?? 30.0),
      ),
    ),
    child: child,
  );
}

Widget appElevatedButtonText(String texto, {required void Function() function, Color? color, Color? textColor, double? width, double? height, double? borderRadius}) {
  return elevatedButtonPadrao(
    appText(texto, color: textColor ?? const Color.fromRGBO(34, 111, 162, 1), bold: true, fontSize: AppFontSizes.small),
    function: function,
    backgroundColor: color,
    width: width,
    height: height,
    borderRadius: borderRadius,
  );
}
