import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

formFieldPadrao(
  BuildContext context,
  String text, {
  double? width,
  bool? showSenha,
  TextEditingController? controller,
  TextInputType? textInputType,
  String? Function(String? value)? validator,
  TextInputFormatter? textInputFormatter,
  Icon? icon,
}) {
  return SizedBox(
    width: width,
    child: TextFormField(
      controller: controller,
      obscureText: showSenha != null ? !showSenha : false,
      style: const TextStyle(fontFamily: 'source', fontSize: 15, color: Colors.white),
      keyboardType: textInputType ?? TextInputType.name,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      validator: validator,
      inputFormatters: textInputFormatter != null ? [textInputFormatter] : null,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, strokeAlign: 5)),
        disabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, strokeAlign: 5)),
        focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        hintText: text,
        hintStyle: const TextStyle(fontFamily: 'source', fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
