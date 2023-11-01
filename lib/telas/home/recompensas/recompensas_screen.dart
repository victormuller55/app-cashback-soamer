import 'dart:ui';

import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_bloc.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_event.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_state.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/erro.dart';
import 'package:app_cashback_soamer/widgets/form_field.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecompensasScreen extends StatefulWidget {
  const RecompensasScreen({super.key});

  @override
  State<RecompensasScreen> createState() => _RecompensasScreeenState();
}

class _RecompensasScreeenState extends State<RecompensasScreen> {

  VaucherBloc vaucherBloc = VaucherBloc();
  TextEditingController controllerValor = TextEditingController();

  Future<void> _load() async {
    vaucherBloc.add(VaucherLoadEvent());
  }

  @override
  void initState() {
    _load();
    super.initState();
  }

  void _popupPIX() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: container(
              radius: BorderRadius.circular(20),
              height: 190,
              width: 240,
              backgroundColor: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    container(
                      radius: BorderRadius.circular(10),
                      padding: const EdgeInsets.all(8),
                      backgroundColor: Colors.grey.shade700,
                      child: text("Digite o valor que será enviado através de uma tranferencia PIX", textAlign: TextAlign.center, color: Colors.white, bold: true),
                    ),
                    formFieldPadrao(context, "Digite o valor", controller: controllerValor, showSenha: false),
                    elevatedButtonText(
                      "SALVAR",
                      function: () => Navigator.pop(context),
                      color: AppColor.primaryColor,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _body(VaucherState state) {

    List<Widget> lista1 = [];
    List<Widget> lista2 = [];
    List<Widget> lista3 = [];

    for (int i = 0; i <= state.vaucherModelList.length - 1; i++) {
      lista1.add(cardVaucher(state.vaucherModelList[i], "1hero$i", vaucherBloc.state.dadosUsuarioModel.pontosUsuario!));
    }

    for (int i = 0; i <= state.vaucherModelListMaisTrocados.length - 1; i++) {
      lista2.add(cardVaucher(state.vaucherModelListMaisTrocados[i], "2hero$i", vaucherBloc.state.dadosUsuarioModel.pontosUsuario!));
    }

    for (int i = 0; i <= state.vaucherModelListPromocao.length - 1; i++) {
      lista3.add(cardVaucher(state.vaucherModelListPromocao[i], "3hero$i", vaucherBloc.state.dadosUsuarioModel.pontosUsuario!));
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          container(
            height: 130,
            width: MediaQuery.of(context).size.width,
            radius: BorderRadius.circular(10),
            backgroundColor: Colors.grey.shade300,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                text("Cashbacks via PIX podem demorar até 3 dias para serem depositados na conta do usuário, representando apenas 40% do valor dos pontos acumulados.", color: Colors.grey.shade700, textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    text("R\$${vaucherBloc.state.dadosUsuarioModel.pontosUsuario},00", fontSize: 22),
                    elevatedButtonText("Solicitar valor".toUpperCase(), function: () => _popupPIX(), width: 230, height: 40, color: AppColor.primaryColor, textColor: Colors.white, borderRadius: 50),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4, top: 15),
            child: text("Lista de vouchers", bold: true, color: AppColor.primaryColor, fontSize: 14),
          ),
          SizedBox(
            height: 180,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: lista1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4, top: 5),
            child: text("Voucher mais trocados", bold: true, color: AppColor.primaryColor, fontSize: 14),
          ),
          SizedBox(
            height: 180,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: lista2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4, top: 5),
            child: text("Voucher em promoção", bold: true, color: AppColor.primaryColor, fontSize: 14),
          ),
          SizedBox(
            height: 180,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: lista3,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _bodyBuilder() {
    return RefreshIndicator(
      onRefresh: _load,
      child: BlocConsumer<VaucherBloc, VaucherState>(
        bloc: vaucherBloc,
        listener: (context, state) => {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case VaucherLoadingState:
              return loading();
            case VaucherSuccessState:
              return _body(state);
            case VaucherErrorState:
              return erro(state.errorModel, function: () => _load());
            default:
              return container();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      body: _bodyBuilder(),
      title: "Recompensas",
      hideBackArrow: true,
      actions: [
        infoColumn(
          title: vaucherBloc.state.dadosUsuarioModel.pontosUsuario.toString(),
          value: "Pontos",
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ]
    );
  }
}
