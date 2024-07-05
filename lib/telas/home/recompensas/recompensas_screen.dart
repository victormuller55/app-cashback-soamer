import 'package:app_cashback_soamer/app_widget/app_consts/app_animations.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart' as cashboost;
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_bloc.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_event.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_state.dart';
import 'package:app_cashback_soamer/widgets/voucher_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muller_package/muller_package.dart';

class RecompensasScreen extends StatefulWidget {
  const RecompensasScreen({super.key});

  @override
  State<RecompensasScreen> createState() => _RecompensasScreeenState();
}

class _RecompensasScreeenState extends State<RecompensasScreen> {

  VaucherBloc bloc = VaucherBloc();
  TextEditingController valor = TextEditingController();

  Future<void> _load() async {
    bloc.add(VaucherLoadEvent());
  }

  @override
  void initState() {
    _load();
    super.initState();
  }

  Widget componenteVoucher({required String title, required List<Widget> lista}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appSizedBox(height:AppSpacing.normal),
        appText(title, bold: true, color: cashboost.AppColors.grey, fontSize: AppFontSizes.normal),
        SizedBox(
          height: lista.isNotEmpty ? 180 : 100,
          child: lista.isNotEmpty
              ? ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: lista,
                )
              : Center(child: appText(AppStrings.nenhumVoucherEncontrado, color: cashboost.AppColors.grey)),
        ),
      ],
    );
  }

  Widget _body(VaucherState state) {

    List<Widget> vouchers = [];
    List<Widget> maisTrocados = [];
    List<Widget> promocao = [];

    for (int i = 0; i <= state.vouchersLista.length - 1; i++) {
      vouchers.add(cardVaucher(state.vouchersLista[i], "1hero$i", bloc.state.dadosVendedorModel.pontos!));
    }

    for (int i = 0; i <= state.maisTrocadosLista.length - 1; i++) {
      maisTrocados.add(cardVaucher(state.maisTrocadosLista[i], "2hero$i", bloc.state.dadosVendedorModel.pontos!));
    }

    for (int i = 0; i <= state.promocaoLista.length - 1; i++) {
      promocao.add(cardVaucher(state.promocaoLista[i], "3hero$i", bloc.state.dadosVendedorModel.pontos!));
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          appContainer(
            height: 130,
            width: MediaQuery.of(context).size.width,
            radius: BorderRadius.circular(AppRadius.medium),
            backgroundColor: cashboost.AppColors.grey300,
            padding: EdgeInsets.all(AppSpacing.normal),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                appText(AppStrings.textoPix, color: cashboost.AppColors.grey700, textAlign: TextAlign.center),
                appSizedBox(height:AppSpacing.normal),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    appText(
                      "R\$${bloc.state.dadosVendedorModel.pontos},00",
                      fontSize: AppFontSizes.big,
                      bold: true,
                      color: cashboost.AppColors.primaryColor,
                    ),
                    appElevatedButtonText(
                      AppStrings.solicitarValor.toUpperCase(),
                      function: () => {},
                      width: 180,
                      height: 40,
                      borderRadius: AppRadius.big,
                      color: cashboost.AppColors.primaryColor,
                      textColor: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          ),
          componenteVoucher(title: AppStrings.todos, lista: vouchers),
          componenteVoucher(title: AppStrings.maisTrocados, lista: maisTrocados),
          componenteVoucher(title: AppStrings.emPromocao, lista: promocao),
          appSizedBox(height:AppSpacing.big),
        ],
      ),
    );
  }

  Widget _bodyBuilder() {
    return RefreshIndicator(
      onRefresh: _load,
      color: Colors.white,
      strokeWidth: 2,
      backgroundColor: cashboost.AppColors.primaryColor,
      child: BlocBuilder<VaucherBloc, VaucherState>(
        bloc: bloc,
        builder: (context, state) {

          switch (state.runtimeType) {
            case VaucherLoadingState:
              return appLoadingAnimation(animation: AppAnimations.loading);
            case VaucherSuccessState:
              return _body(state);
            case VaucherErrorState:
              return appError(state.errorModel, function: () => _load());
            default:
              return appContainer();
          }

        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      body: _bodyBuilder(),
      appBarBackground: cashboost.AppColors.primaryColor,
      title: AppStrings.recompensas,
      hideBackArrow: true,
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
