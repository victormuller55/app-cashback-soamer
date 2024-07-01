import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_bloc.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_event.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_state.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/erro.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/sized_box.dart';
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

  Widget componenteVoucher({required String title, required List<Widget> lista}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appSizedBoxHeight(10),
        text(title, bold: true, color: Colors.grey, fontSize: 14),
        SizedBox(
          height: lista.isNotEmpty ? 180 : 100,
          child: lista.isNotEmpty
              ? ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: lista,
                )
              : Center(child: text("Nenhum Voucher Encontrado", color: Colors.grey)),
        ),
      ],
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
        physics: const BouncingScrollPhysics(),
        children: [
          container(
            height: 130,
            width: MediaQuery.of(context).size.width,
            radius: BorderRadius.circular(20),
            backgroundColor: Colors.grey.shade300,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                text("Cashbacks via PIX podem demorar até 3 dias para serem depositados na conta do usuário.", color: Colors.grey.shade700, textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    text("R\$${vaucherBloc.state.dadosUsuarioModel.pontosUsuario},00", fontSize: 22, bold: true, color: AppColor.primaryColor),
                    elevatedButtonText("Solicitar valor".toUpperCase(), function: () => {}, width: 180, height: 40, color: AppColor.primaryColor, textColor: Colors.white, borderRadius: 50),
                  ],
                )
              ],
            ),
          ),
          componenteVoucher(title: "TODOS", lista: lista1),
          componenteVoucher(title: "MAIS TROCADOS", lista: lista2),
          componenteVoucher(title: "PROMOÇÃO", lista: lista3),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _bodyBuilder() {
    return RefreshIndicator(
      onRefresh: _load,
      color: Colors.white,
      strokeWidth: 2,
      backgroundColor: AppColor.primaryColor,
      child: BlocConsumer<VaucherBloc, VaucherState>(
        bloc: vaucherBloc,
        listener: (context, state) => state is VaucherSuccessState ? () => Future.delayed(const Duration(milliseconds: 500)).then((value) => setState(() {})) : () => {},
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
    );
  }
}
