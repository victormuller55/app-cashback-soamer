import 'package:flutter/material.dart';

import 'container.dart';

void showModalEmpty(
  BuildContext context, {
  required Widget child,
  double? height,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return container(
        height: height ?? 300,
        width: MediaQuery.of(context).size.width,
        backgroundColor: Colors.white,
        radius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            container(
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
  );
}
