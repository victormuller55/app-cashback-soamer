import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

Widget erro(ErrorModel errorModel, {required void Function() function}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 80, height: 80, child: Image.asset("assets/images/error.png")),
        const SizedBox(height: 10),
        appText(errorModel.erro ?? "Ocorreu um erro", color: AppColors.primaryColor, bold: true, fontSize: 20),
        const SizedBox(height: 10),
        appText(errorModel.mensagem ?? "Tente novamente mais tarde"),
        const SizedBox(height: 20),
        appElevatedButtonText("Tentar novamente".toUpperCase(), function: function, width: 250)
      ],
    ),
  );
}
