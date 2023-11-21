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
import 'package:app_cashback_soamer/widgets/sized_box.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrarVendaScreen extends StatefulWidget {
  const RegistrarVendaScreen({super.key});

  @override
  State<RegistrarVendaScreen> createState() => _RegistrarVendaScreenState();
}

class _RegistrarVendaScreenState extends State<RegistrarVendaScreen>{
  RegistrarVendaBloc bloc = RegistrarVendaBloc();
  TextEditingController formNFCE = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  int selected = -1;

  void _save() {
    if (formNFCE.text.isNotEmpty) {
      return bloc.add(RegistrarVendaLoadEvent(formNFCE.text, selected.toString()));
    }

    return showSnackbarError(context, message: "Digite ou escaneie o código");
  }

  Future<void> scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#FFFFFF', 'CANCELAR', false, ScanMode.BARCODE);

    if (barcodeScanRes != '-1') {
      return setState(() => formNFCE.text = barcodeScanRes);
    }

    return showSnackbarWarning(context, message: "Não foi possivel escanear o código de barras");
  }

  void selectContainer(int index) {
    setState(() {
      if (selected == index) {
        selected = -1;
      } else {
        selected = index;
      }
    });
  }

  Widget buildContainer(int index, String image, String nome) {
    return GestureDetector(
      onTap: () => selectContainer(index),
      child: container(
        backgroundColor: selected == index ? AppColor.primaryColor : Colors.grey.shade300,
        radius: BorderRadius.circular(20),
        border: Border.all(color: selected == index ? AppColor.primaryColor : Colors.grey.shade300, width: 3),
        child: Column(
          children: [
            container(
              height: 160,
              width: 160,
              radius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
              image: AssetImage("assets/images/ponteiras/$image"),
            ),
            container(height: 2, backgroundColor: selected == index ? AppColor.primaryColor : Colors.grey.shade300, width: 160),
            sizedBoxVertical(5),
            text(nome, color: selected == index ? Colors.white : Colors.grey),
            sizedBoxVertical(5),
            text(nome.contains("dupla") ? "+20 Pontos" : "+ 10 Pontos", color: selected == index ? Colors.white : Colors.grey, bold: true, fontSize: 16),
            sizedBoxVertical(5),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          container(
            backgroundColor: Colors.grey.shade300,
            radius: BorderRadius.circular(10),
            padding: const EdgeInsets.all(10),
            child: text('Digite o código NF-E abaixo, ou escaneie o código de barras da NF-E para registrar a venda e ganhar pontos.', textAlign: TextAlign.center),
          ),
          sizedBoxVertical(10),
          formFieldPadrao(context, "Digite o número da NF-E", textInputFormatter: FormFieldFormatter.nfeFormatter, textInputType: TextInputType.number, controller: formNFCE),
          sizedBoxVertical(10),
          text('OU', textAlign: TextAlign.center, bold: true, color: AppColor.primaryColor),
          sizedBoxVertical(10),
          elevatedButtonText(
            "Escanear código de barras".toUpperCase(),
            function: () => scanBarcode(),
            color: AppColor.primaryColor,
            textColor: Colors.white,
            width: MediaQuery.of(context).size.width,
          ),
          const Divider(),
          container(
            backgroundColor: Colors.grey.shade300,
            radius: BorderRadius.circular(10),
            padding: const EdgeInsets.all(10),
            child: text('Selecione a ponteira vendida', textAlign: TextAlign.center),
          ),
          sizedBoxVertical(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildContainer(0, "black_piano_dupla.jpg", "Black piano (dupla)"),
              buildContainer(1, "black_piano_simples.jpg", "Black piano (simples)"),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildContainer(2, "polida_dupla.jpg", "Polida (dupla)"),
              buildContainer(3, "polida_simples.jpg", "Polida (Simples)"),
            ],
          ),
          sizedBoxVertical(20),
          elevatedButtonText(
            "Enviar NF-E".toUpperCase(),
            function: () => _save(),
            color: AppColor.primaryColor,
            textColor: Colors.white,
            width: MediaQuery.of(context).size.width,
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
      bloc: bloc,
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

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
