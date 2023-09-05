import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void showLoading(BuildContext context, {String? mensagem}) {
  showDialog(
    barrierDismissible: false,
    useRootNavigator: false,
    useSafeArea: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          height: 100,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.staggeredDotsWave(color: const Color.fromRGBO(34, 111, 162, 1), size: 50),
              text(mensagem ?? "Carregando...", bold: true, color: const Color.fromRGBO(34, 111, 162, 1)),
            ],
          ),
        ),
      );
    },
  );
}
