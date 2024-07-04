import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_strings.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';
import 'package:app_cashback_soamer/telas/vaucher/voucher_bloc.dart';
import 'package:app_cashback_soamer/telas/vaucher/voucher_event.dart';
import 'package:app_cashback_soamer/telas/vaucher/voucher_state.dart';
import 'package:app_cashback_soamer/widgets/circular_avatar.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/erro.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/modal.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VaucherScreen extends StatefulWidget {
  final VaucherModel vaucherModel;
  final String heroImage;
  final int pontos;

  const VaucherScreen({
    super.key,
    required this.vaucherModel,
    required this.heroImage,
    required this.pontos,
  });

  @override
  State<VaucherScreen> createState() => _VaucherScreenState();
}

class _VaucherScreenState extends State<VaucherScreen> {
  VoucherBloc voucherBloc = VoucherBloc();

  Widget _bodySuccess(VoucherState voucherState) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            avatar(AppEndpoints.endpointImageVoucher(widget.vaucherModel.id!), radius: 80),
            const SizedBox(height: 15),
            appText(
              "VOUCHER ADQUIRIDO \n COM SUCESSO!",
              bold: true,
              color: AppColors.primaryColor,
              fontSize: 17,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            appContainer(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              backgroundColor: Colors.green,
              radius: BorderRadius.circular(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appText(
                    "Verifique seu e-mail",
                    color: Colors.white,
                    fontSize: 16,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.email, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 10),
            appContainer(
              radius: BorderRadius.circular(20),
              padding: const EdgeInsets.all(10),
              backgroundColor: Colors.grey.shade300,
              child: appText(
                "Após adquirir o voucher, o código será enviado para o seu e-mail conectado à conta. Por favor, verifique a pasta de descontos e spam ao verificar o e-mail, pois o processo pode levar até 1 dia para ser concluído. Fique atento e aproveite seus benefícios!",
                color: Colors.grey.shade600,
                fontSize: 15,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            appElevatedButtonText(
              "CONCLUIR",
              function: () => Navigator.pop(context),
              color: AppColors.primaryColor,
              textColor: Colors.white,
              width: MediaQuery.of(context).size.width,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _showModal() {
    showModalEmpty(
      context,
      height: 350,
      child: Column(
        children: [
          appText(widget.vaucherModel.titulo!, fontSize: 18, bold: true),
          const SizedBox(height: 10),
          appContainer(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            backgroundColor: Colors.grey.shade300,
            radius: BorderRadius.circular(10),
            child: Center(child: appText("Você realmente deseja trocar ${widget.vaucherModel.pontos} pontos deste vaucher?", fontSize: 15, textAlign: TextAlign.center)),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appText("Saldo atual: ", bold: true, fontSize: 17, color: Colors.grey.shade600),
              appText("${widget.pontos} Pontos", bold: true, fontSize: 17, color: Colors.grey.shade800),
            ],
          ),
          const SizedBox(height: 5),
          appText("Após da troca: ${widget.pontos - widget.vaucherModel.pontos! <= 0 ? 0 : widget.pontos - widget.vaucherModel.pontos!} Pontos", fontSize: 15, color: Colors.grey.shade600),
          const SizedBox(height: 20),
          appElevatedButtonText(
            "TROCAR",
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
            textColor: Colors.white,
            function: () {
              if (widget.vaucherModel.pontos! <= widget.pontos) {
                voucherBloc.add(VoucherTrocarEvent(widget.vaucherModel.id!));
                Navigator.pop(context);
              } else {
                showSnackbarWarning(message: "Pontos insuficientes");
                Navigator.pop(context);
              }
            },
          ),
          const SizedBox(height: 10),
          appElevatedButtonText(
            "CANCELAR",
            width: MediaQuery.of(context).size.width,
            function: () => Navigator.pop(context),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buttonTrocar() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: appElevatedButtonText(
        "TROCAR CUPOM",
        function: () => _showModal(),
        color: AppColors.primaryColor,
        textColor: Colors.white,
      ),
    );
  }

  Widget _body() {
    return ListView(
      children: [
        Hero(
          tag: widget.heroImage,
          child: appContainer(
            height: 200,
            width: MediaQuery.of(context).size.width,
            backgroundColor: Colors.grey.shade300,
            image: NetworkImage(AppEndpoints.endpointImageVoucher(widget.vaucherModel.id!)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  infoColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    title: widget.vaucherModel.titulo ?? "",
                    value: "Até ${widget.vaucherModel.dataFinal}",
                    titleColor: Colors.black,
                    valueColor: Colors.grey.shade600,
                    titleSize: 18,
                    valueSize: 15,
                    spacing: true,
                  ),
                  infoColumn(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    title: widget.vaucherModel.desconto == 0 ? "" : "${widget.vaucherModel.pontosCheio} Pontos",
                    value: widget.vaucherModel.desconto == 0 ? "${widget.vaucherModel.pontosCheio} Pontos" : "${widget.vaucherModel.pontos} Pontos",
                    titleColor: Colors.red,
                    valueColor: Colors.black,
                    titleSize: 14,
                    valueSize: 18,
                    cortarTitle: true,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              appContainer(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.grey.shade300,
                radius: BorderRadius.circular(20),
                child: Center(child: appText(widget.vaucherModel.info!, fontSize: 15, textAlign: TextAlign.justify)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ExpansionTile(
          collapsedBackgroundColor: Colors.white,
          textColor: Colors.black,
          title: appText("Por quanto tempo posso utilizar o voucher?"),
          children: [
            appContainer(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              backgroundColor: Colors.grey.shade300,
              child: Center(
                child: appText(
                  AppStrings.explicacaoComoUtilizarVoucher,
                  fontSize: 15,
                  color: Colors.grey.shade600,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
        ExpansionTile(
          collapsedBackgroundColor: Colors.white,
          textColor: Colors.black,
          title: appText("Por quanto tempo posso utilizar o voucher?"),
          children: [
            appContainer(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              backgroundColor: Colors.grey.shade300,
              child: Center(
                child: appText(
                  AppStrings.explicacaoTempoVoucher,
                  fontSize: 15,
                  textAlign: TextAlign.justify,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _bodyBuilder() {
    return BlocConsumer<VoucherBloc, VoucherState>(
      bloc: voucherBloc,
      listener: (context, state) => setState(() {}),
      builder: (context, state) {
        switch (state.runtimeType) {
          case VoucherLoadingState:
            return loading();
          case VoucherErrorState:
            return erro(state.errorModel, function: () => {});
          case VoucherSuccessState:
            return _bodySuccess(state);
          default:
            return _body();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      body: _bodyBuilder(),
      title: widget.vaucherModel.titulo ?? "",
      bottomNavigationBar: voucherBloc.state.runtimeType == VoucherSuccessState ? null : _buttonTrocar(),
      actions: [
        infoColumn(
          title: widget.pontos.toString(),
          value: "Pontos",
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ],
    );
  }

  @override
  void dispose() {
    voucherBloc.close();
    super.dispose();
  }
}
