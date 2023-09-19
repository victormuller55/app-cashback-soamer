import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget loading() {
  return Center(child: LoadingAnimationWidget.twoRotatingArc(color: AppColor.primaryColor, size: 40));
}