import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';
import 'package:app_cashback_soamer/telas/vaucher/voucher_screen.dart';
import 'package:flutter/material.dart';
import 'package:muller_package/muller_package.dart';

Widget cardVaucher(VaucherModel vaucherModel, String heroImage, int pontos) {

  int days = formataDDMMYYYYHHMMParaDateTime(vaucherModel.dataFinal!).difference(DateTime.now()).inDays;

  return Builder(builder: (context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => open(screen: VaucherScreen(model: vaucherModel, hero: heroImage, pontos: pontos)),
          child: appContainer(
            height: 165,
            width: 165,
            radius: BorderRadius.circular(20),
            backgroundColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: heroImage,
                  child: appContainer(
                    height: 85,
                    width: 165,
                    backgroundColor: Colors.grey.shade300,
                    radius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    image: NetworkImage(AppEndpoints.endpointImageVoucher(vaucherModel.id!)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 7, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appText(vaucherModel.titulo ?? "vazio", fontSize: 14, bold: true, overflow: true),
                      const SizedBox(height: 5),
                      vaucherModel.desconto! > 0 ? appText("${vaucherModel.pontosCheio} Pontos", color: Colors.red, fontSize: 13, cortado: true) : const SizedBox(),
                      const SizedBox(height: 3),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          appText("${vaucherModel.pontos} Pontos", bold: true, color: Colors.black, fontSize: 14),
                          Row(
                            children: [
                              const Icon(Icons.timer_sharp, size: 20, color: Colors.grey),
                              appText("${days}d", fontSize: 13, color: Colors.grey),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  });
}