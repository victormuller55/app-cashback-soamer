import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';
import 'package:app_cashback_soamer/telas/voucher/voucher_screen.dart';
import 'package:flutter/material.dart';
import 'package:muller_package/muller_package.dart';

Widget _imageVoucher(String hero, VaucherModel voucherModel) {
  return Hero(
    tag: hero,
    child: appContainer(
      height: 85,
      width: 165,
      backgroundColor: AppColors.grey300,
      radius: BorderRadius.only(topLeft: Radius.circular(AppRadius.medium), topRight: Radius.circular(AppRadius.medium)),
      image: NetworkImage(AppEndpoints.endpointImageVoucher(voucherModel.id!)),
    ),
  );
}

Widget _descontoVoucher(VaucherModel voucherModel) {
  if (voucherModel.desconto != 0) {
    return appText(
      "${voucherModel.pontosCheio} Pontos",
      color: AppColors.red,
      fontSize: AppFontSizes.small,
      cortado: true,
    );
  }
  return appSizedBox();
}

Widget _pontosValidade(VaucherModel vaucherModel) {
  int days = formataDDMMYYYYHHMMParaDateTime(vaucherModel.dataFinal!).difference(DateTime.now()).inDays;

  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      appText("${vaucherModel.pontos} Pontos", bold: true, color: AppColors.black, fontSize: AppFontSizes.normal),
      Row(
        children: [
          Icon(AppIcons.tempo, size: 20, color: AppColors.grey),
          appText("${days}d", fontSize: AppFontSizes.normal, color: AppColors.grey),
        ],
      )
    ],
  );
}

Widget cardVoucher(VaucherModel vaucherModel, String heroImage, int pontos) {
  return GestureDetector(
    onTap: () => open(screen: VaucherScreen(model: vaucherModel, hero: heroImage, pontos: pontos)),
    child: appContainer(
      height: 165,
      width: 165,
      margin: EdgeInsets.only(right: AppSpacing.normal, top: AppSpacing.normal),
      radius: BorderRadius.circular(AppRadius.medium),
      backgroundColor: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageVoucher(heroImage, vaucherModel),
          Padding(
            padding: EdgeInsets.only(
              left: AppSpacing.normal,
              top: AppSpacing.small,
              right: AppSpacing.normal,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appText(
                  vaucherModel.titulo ?? AppStrings.vazio,
                  fontSize: AppFontSizes.small,
                  bold: true,
                  overflow: true,
                ),
                appSizedBox(height: AppSpacing.small),
                _descontoVoucher(vaucherModel),
                appSizedBox(height: AppSpacing.small),
                _pontosValidade(vaucherModel),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
