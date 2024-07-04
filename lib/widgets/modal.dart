import 'package:flutter/material.dart';

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
      return appContainer(
        height: height ?? 300,
        width: MediaQuery.of(context).size.width,
        backgroundColor: Colors.grey.shade200,
        radius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appContainer(
              height: 7,
              width: 120,
              backgroundColor: Colors.grey,
              radius: BorderRadius.circular(20),
            ),
            child,
          ],
        ),
      );
    },
  ).then((value) => function);
}
