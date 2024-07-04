import 'package:app_cashback_soamer/app_widget/app_consts/app_animations.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart';
import 'package:app_cashback_soamer/widgets/animations.dart';
import 'package:app_cashback_soamer/widgets/sized_box.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

Widget loadingAnimation({Color? color}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        appAnimation(AppAnimations.loading, height: 200),
        appSizedBoxHeight(30),
        appText("Carregando...", bold: true, color: color ?? AppColors.primaryColor),
      ],
    ),
  );
}

Widget loading({Color? color}) {
  return Center(
    child: SizedBox(
      width: 50,
      height: 50,
      child: CircularProgressIndicator(color: color),
    ),
  );
}
