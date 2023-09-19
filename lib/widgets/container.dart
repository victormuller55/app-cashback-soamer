import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

Widget container({
  // Alignments
  MainAxisAlignment? mainAxisAlignment,

  // CONTAINER CONFIGS
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  double? height,
  double? width,
  Color? backgroundColor,
  BorderRadiusGeometry? radius,
  BoxBorder? border,
  BoxShape? shape,
  BoxShadow? shadow,
  Gradient? gradient,
  ImageProvider<Object>? image,
  Widget? child,

  // BOTTOM TEXT CONFIGS
  String? bottomText,
  Color? bottomFontColor,
}) {
  return Container(
    margin: margin,
    padding: padding,
    height: height,
    width: width,
    decoration: BoxDecoration(
      image: image != null ? DecorationImage(image: image, fit: BoxFit.cover) : null,
      color: backgroundColor,
      borderRadius: radius,
      border: border,
      gradient: gradient,
      boxShadow: shadow != null ? [shadow] : null,
    ),
    child: child,
  );
}

Widget cardVaucher(VaucherModel vaucherModel) {
  return Row(
    children: [
      const SizedBox(width: 10),
      container(
        height: 170,
        width: 170,
        radius: BorderRadius.circular(10),
        backgroundColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            container(
              height: 85,
              width: 170,
              backgroundColor: Colors.grey.shade300,
              radius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              image: const NetworkImage("https://i0.wp.com/flyassist.com.br/wp-content/uploads/2020/10/fly_assist_travel_voucher_possibilidades-3.jpg?fit=1920%2C1080&ssl=1"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text(vaucherModel.tituloVaucher!, fontSize: 16),
                  const SizedBox(height: 5),
                  vaucherModel.descontoVaucher! > 0 ? text("${vaucherModel.pontosCheioVaucher} Pontos", color: Colors.red, fontSize: 17, cortado: true) : const SizedBox(),
                  const SizedBox(height: 3),
                  text("${vaucherModel.pontosVaucher} Pontos", bold: true, color: AppColor.primaryColor, fontSize: 19),
                ],
              ),
            )
          ],
        ),
      ),
    ],
  );
}
