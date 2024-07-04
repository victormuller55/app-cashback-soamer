import 'package:app_cashback_soamer/app_widget/app_consts/app_spacing.dart';
import 'package:app_cashback_soamer/widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import 'container.dart';

void showModalEmpty(
  BuildContext context, {
  required Widget child,
  double? height,
  bool? isDismissible,
  void Function()? function,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isDismissible: isDismissible ?? true,
    builder: (context) {
      return KeyboardAvoider(
        autoScroll: true,
        child: appContainer(
          height: height ?? 300,
          width: MediaQuery.of(context).size.width,
          backgroundColor: Colors.grey.shade200,
          radius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              appContainer(
                height: 7,
                width: 120,
                backgroundColor: Colors.grey,
                radius: BorderRadius.circular(20),
              ),
              appSizedBoxHeight(AppSpacing.normal),
              child,
            ],
          ),
        ),
      );
    },
  ).then((value) => function);
}
