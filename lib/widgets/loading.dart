import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/cupertino.dart';

Widget loading({Color? color}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 80, width: 80, child: Image.asset("assets/gif/load_wheel.gif")),
        text("Carregando...", bold: true, color: AppColor.primaryColor),
      ],
    ),
  );
}
