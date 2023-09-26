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
      style: const TextStyle(fontFamily: 'lato', fontSize: 15, color: Colors.black),
      keyboardType: textInputType ?? TextInputType.name,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      validator: validator,
      inputFormatters: textInputFormatter != null ? [textInputFormatter] : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent, width: 0.5), borderRadius: BorderRadius.circular(40)),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent, strokeAlign: 5), borderRadius: BorderRadius.circular(40)),
        disabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(40)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent, strokeAlign: 5), borderRadius: BorderRadius.circular(40)),
        focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(40)),
        errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(40)),
        hintText: text,
        hintStyle: const TextStyle(fontFamily: 'lato', fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
