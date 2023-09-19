import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

Widget elevatedButtonPadrao(Widget child, {required void Function() function, bool? transparente, double? width}) {
  return ElevatedButton(
    onPressed: function,
    style: ElevatedButton.styleFrom(
      backgroundColor: transparente ?? false ? Colors.transparent : Colors.white,
      fixedSize: Size(width ?? 300, 50),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: transparente ?? false ? Colors.white : Colors.transparent),
        borderRadius: BorderRadius.circular(30.0), // Ajuste o valor do raio conforme necessário
      ),
    ),
    child: child,
  );
}

Widget elevatedButtonText(String texto, {required void Function() function, bool? transparente, double? width}) {
  return elevatedButtonPadrao(
    text(texto, color: transparente ?? false ? Colors.white : const Color.fromRGBO(34, 111, 162, 1), bold: true),
    function: function,
    transparente: transparente,
    width: width,
  );
}
