import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/app_widget/form_field_formatters/form_field_formatter.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/telas/registrar_venda/registrar_venda_bloc.dart';
import 'package:app_cashback_soamer/telas/registrar_venda/registrar_venda_event.dart';
import 'package:app_cashback_soamer/telas/registrar_venda/registrar_venda_state.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/form_field.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrarVendaScreen extends StatefulWidget {
  const RegistrarVendaScreen({super.key});

  @override
  State<RegistrarVendaScreen> createState() => _RegistrarVendaScreenState();
}

class _RegistrarVendaScreenState extends State<RegistrarVendaScreen> {
  RegistrarVendaBloc registrarVendaBloc = RegistrarVendaBloc();
  TextEditingController nfeController = TextEditingController();

  void _save() {
    if (nfeController.text.isNotEmpty) {
      registrarVendaBloc.add(RegistrarVendaLoadEvent(nfeController.text));
    } else {
      showSnackbarError(context, message: "Digite ou escaneie o código");
    }
  }

  Future<void> scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#FFFFFF', 'CANCELAR', false, ScanMode.BARCODE);
    if (barcodeScanRes != '-1') {
      setState(() => nfeController.text = barcodeScanRes);
    } else {
      showSnackbarWarning(context, message: "Não foi possivel escanear o código de barras");
    }
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              container(
                backgroundColor: Colors.grey.shade300,
                radius: BorderRadius.circular(10),
                padding: const EdgeInsets.all(10),
                child: text('Digite o código NF-E abaixo, ou escaneie o código de barras da NF-E para registrar a venda e ganhar pontos.', textAlign: TextAlign.center),
              ),
              const SizedBox(height: 10),
              formFieldPadrao(context, "Digite o número da NF-E", textInputFormatter: FormFieldFormatter.nfeFormatter, textInputType: TextInputType.number, controller: nfeController),
              const SizedBox(height: 10),
              text('OU', textAlign: TextAlign.center, bold: true, color: AppColor.primaryColor),
              const SizedBox(height: 10),
              elevatedButtonText(
                "Escanear código de barras".toUpperCase(),
                function: () => scanBarcode(),
                color: AppColor.primaryColor,
                textColor: Colors.white,
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
          Hero(
            tag: "floatingButton",
            child: elevatedButtonText(
              "Enviar NF-E".toUpperCase(),
              function: () => _save(),
              color: AppColor.primaryColor,
              textColor: Colors.white,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }

  void _onChangeState(RegistrarVendaState state) {
    if (state is RegistrarVendaErrorState) showSnackbarError(context, message: state.errorModel.mensagem);
    if (state is RegistrarVendaSuccessState) {
        showSnackbarSuccess(context, message: "NF-E registrada com sucesso");
        Navigator.pop(context);
    }
  }

  Widget _bodyBuilder() {
    return BlocConsumer<RegistrarVendaBloc, RegistrarVendaState>(
      bloc: registrarVendaBloc,
      listener: (context, state) => _onChangeState(state),
      builder: (context, state) {
        switch (state.runtimeType) {
          case RegistrarVendaLoadingState:
            return loading();
          default:
            return _body();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: "Registrar venda",
      body: _bodyBuilder(),
    );
  }
}
