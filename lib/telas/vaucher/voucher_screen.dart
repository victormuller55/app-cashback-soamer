import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/app_widget/strings.dart';
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
import 'package:flutter/services.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          avatar("https://i0.wp.com/flyassist.com.br/wp-content/uploads/2020/10/fly_assist_travel_voucher_possibilidades-3.jpg?fit=1920%2C1080&ssl=1", radius: 80),
          const SizedBox(height: 15),
          text("VOUCHER ADQUIRIDO \n COM SUCESSO!", bold: true, color: AppColor.primaryColor, fontSize: 17, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          text("Aqui está o código de seu voucher", bold: true, color: Colors.grey.shade600, fontSize: 15, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          container(
            width: 350,
            height: 60,
            padding: const EdgeInsets.all(10),
            backgroundColor: Colors.white,
            radius: BorderRadius.circular(10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  text(voucherState.code, fontSize: 20, textAlign: TextAlign.center, bold: true, color: AppColor.primaryColor),
                  IconButton(
                    onPressed: () {
                      showSnackbarSuccess(context, message: "Código copiado com sucesso");
                      Clipboard.setData(ClipboardData(text: voucherState.code));
                    },
                    icon: Icon(Icons.copy, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void _showModal() {
    showModalEmpty(
      context,
      height: 350,
      child: Column(
        children: [
          text(widget.vaucherModel.tituloVaucher!, fontSize: 18, bold: true),
          const SizedBox(height: 10),
          container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            backgroundColor: Colors.grey.shade300,
            radius: BorderRadius.circular(10),
            child: Center(child: text("Você realmente deseja trocar ${widget.vaucherModel.pontosVaucher} pontos deste vaucher?", fontSize: 15, textAlign: TextAlign.center)),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text("Saldo atual: ", bold: true, fontSize: 17, color: Colors.grey.shade600),
              text("${widget.pontos} Pontos", bold: true, fontSize: 17, color: Colors.grey.shade800),
            ],
          ),
          const SizedBox(height: 5),
          text("Após da troca: ${widget.pontos - widget.vaucherModel.pontosVaucher!} Pontos", fontSize: 15, color: Colors.grey.shade600),
          const SizedBox(height: 20),
          elevatedButtonText(
            "TROCAR",
            width: MediaQuery.of(context).size.width,
            function: () => {
              voucherBloc.add(VoucherTrocarEvent(widget.vaucherModel.idVaucher!)),
              Navigator.pop(context),
            },
            color: Colors.green,
            textColor: Colors.white,
          ),
          const SizedBox(height: 10),
          elevatedButtonText(
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
      child: elevatedButtonText(
        "TROCAR CUPOM",
        function: () => _showModal(),
        color: AppColor.primaryColor,
        textColor: Colors.white,
      ),
    );
  }

  Widget _body() {
    return ListView(
      children: [
        Hero(
          tag: widget.heroImage,
          child: container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            backgroundColor: Colors.grey.shade300,
            image: const NetworkImage("https://i0.wp.com/flyassist.com.br/wp-content/uploads/2020/10/fly_assist_travel_voucher_possibilidades-3.jpg?fit=1920%2C1080&ssl=1"),
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
                    title: widget.vaucherModel.tituloVaucher ?? "",
                    value: "Até ${widget.vaucherModel.dataFinalVaucher}",
                    titleColor: Colors.black,
                    valueColor: Colors.grey.shade600,
                    titleSize: 18,
                    valueSize: 15,
                    spacing: true,
                  ),
                  infoColumn(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    title: "${widget.vaucherModel.pontosCheioVaucher} Pontos",
                    value: "${widget.vaucherModel.pontosVaucher} Pontos",
                    titleColor: Colors.red,
                    valueColor: Colors.black,
                    titleSize: 14,
                    valueSize: 18,
                    cortarTitle: true,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.grey.shade300,
                radius: BorderRadius.circular(10),
                child: Center(child: text(widget.vaucherModel.infoVaucher!, fontSize: 15)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ExpansionTile(
          collapsedBackgroundColor: Colors.white,
          textColor: Colors.black,
          title: text("Por quanto tempo posso utilizar o voucher?"),
          children: [
            container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              backgroundColor: Colors.grey.shade300,
              child: Center(
                child: text(
                  Strings.explicacaoComoUtilizarVoucher,
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
          title: text("Por quanto tempo posso utilizar o voucher?"),
          children: [
            container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              backgroundColor: Colors.grey.shade300,
              child: Center(
                child: text(
                  Strings.explicacaoTempoVoucher,
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
      listener: (context, state) => {},
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
      title: widget.vaucherModel.tituloVaucher ?? "",
      bottomNavigationBar: _buttonTrocar(),
      actions: [
        infoColumn(
          title: widget.pontos.toString(),
          value: "Pontos",
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ],
    );
  }
}
