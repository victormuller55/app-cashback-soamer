import 'package:app_cashback_soamer/app_widget/app_consts/app_animations.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart' as cashboost;
import 'package:app_cashback_soamer/telas/registrar_venda/registrar_venda_bloc.dart';
import 'package:app_cashback_soamer/telas/registrar_venda/registrar_venda_event.dart';
import 'package:app_cashback_soamer/telas/registrar_venda/registrar_venda_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muller_package/muller_package.dart';

class RegistrarVendaScreen extends StatefulWidget {
  const RegistrarVendaScreen({super.key});

  @override
  State<RegistrarVendaScreen> createState() => _RegistrarVendaScreenState();
}

class _RegistrarVendaScreenState extends State<RegistrarVendaScreen> {
  RegistrarVendaBloc bloc = RegistrarVendaBloc();
  late AppFormField nota;

  int selected = -1;

  @override
  void initState() {
    nota = AppFormField(
      context: context,
      hint: AppStrings.digiteONumeroDaNFE,
      textInputFormatter: AppFormFormatters.nfeFormatter,
      textInputType: TextInputType.number,
    );
    super.initState();
  }

  void _save() {
    if (nota.controller.text.isNotEmpty) {
      if (selected != -1) {
        return bloc.add(RegistrarVendaLoadEvent(nota.controller.text, selected));
      }
      return showSnackbarError(message: AppStrings.selecioneUmaPonteira);
    }

    return showSnackbarError(message: AppStrings.digiteOuEscaneieOCodigo);
  }

  Widget _buttonSave() {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.normal),
      child: Hero(
        tag: "floatingButton",
        child: appElevatedButtonText(
          AppStrings.enviarNFE.toUpperCase(),
          function: () => _save(),
          color: cashboost.AppColors.primaryColor,
          textColor: cashboost.AppColors.white,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  Future<void> scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#FFFFFF', AppStrings.cancelar, false, ScanMode.BARCODE);

    if (barcodeScanRes != '-1') {
      return setState(() => nota.controller.text = barcodeScanRes);
    }

    return showSnackbarWarning(message: AppStrings.naoFoiPossivelEscanearOCodigo);
  }

  void _selectContainer(int index) {
    setState(() {
      if (selected == index) {
        selected = -1;
      } else {
        selected = index;
      }
    });
  }

  Widget _ponteiras(int index, String image, String nome) {
    return GestureDetector(
      onTap: () => _selectContainer(index),
      child: appContainer(
        backgroundColor: selected == index ? cashboost.AppColors.primaryColor : cashboost.AppColors.grey300,
        radius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: selected == index ? cashboost.AppColors.primaryColor : cashboost.AppColors.grey300, width: 3),
        child: Column(
          children: [
            appContainer(
              height: 160,
              width: 160,
              radius: BorderRadius.only(
                topLeft: Radius.circular(AppRadius.medium),
                topRight: Radius.circular(AppRadius.medium),
              ),
              image: AssetImage("assets/images/ponteiras/$image"),
            ),
            appContainer(
              height: 2,
              backgroundColor: selected == index ? cashboost.AppColors.primaryColor : Colors.grey.shade300,
              width: 160,
            ),
            appSizedBox(height: AppSpacing.small),
            appText(nome, color: selected == index ? Colors.white : Colors.grey),
            appSizedBox(height: AppSpacing.small),
            appText(
              nome.contains("dupla") ? "+20 Pontos" : "+ 10 Pontos",
              color: selected == index ? cashboost.AppColors.white : cashboost.AppColors.grey,
              bold: true,
              fontSize: AppFontSizes.normal,
            ),
            appSizedBox(height: AppSpacing.small),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.normal),
      child: ListView(
        children: [
          appContainer(
            backgroundColor: Colors.grey.shade300,
            radius: BorderRadius.circular(AppRadius.normal),
            padding: EdgeInsets.all(AppSpacing.normal),
            child: appText(AppStrings.mensagemNFE, textAlign: TextAlign.center),
          ),
          appSizedBox(height: AppSpacing.normal),
          nota.formulario,
          appSizedBox(height: AppSpacing.normal),
          appText(AppStrings.ou, textAlign: TextAlign.center, bold: true, color: cashboost.AppColors.primaryColor),
          appSizedBox(height: AppSpacing.normal),
          appElevatedButtonText(
            AppStrings.escanearCodigo.toUpperCase(),
            function: () => scanBarcode(),
            color: cashboost.AppColors.primaryColor,
            textColor: cashboost.AppColors.white,
            width: MediaQuery.of(context).size.width,
          ),
          const Divider(),
          appContainer(
            backgroundColor: cashboost.AppColors.grey300,
            radius: BorderRadius.circular(AppRadius.normal),
            padding: EdgeInsets.all(AppSpacing.normal),
            child: appText(AppStrings.selecioneAPonteiraVendida, textAlign: TextAlign.center),
          ),
          appSizedBox(height: AppSpacing.medium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ponteiras(0, "black_piano_dupla.jpg", AppStrings.blackPianoDupla),
              _ponteiras(1, "black_piano_simples.jpg", AppStrings.blackPianoSimples),
            ],
          ),
          appSizedBox(height: AppSpacing.medium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ponteiras(2, "polida_dupla.jpg", AppStrings.polidaDupla),
              _ponteiras(3, "polida_simples.jpg", AppStrings.polidaSimples),
            ],
          ),
          appSizedBox(height: AppSpacing.medium),
        ],
      ),
    );
  }

  void _onChangeState(RegistrarVendaState state) {
    if (state is RegistrarVendaSuccessState) Navigator.pop(context);
  }

  Widget _bodyBuilder() {
    return BlocConsumer<RegistrarVendaBloc, RegistrarVendaState>(
      bloc: bloc,
      listener: (context, state) => _onChangeState(state),
      builder: (context, state) {
        switch (state.runtimeType) {
          case RegistrarVendaLoadingState:
            return appLoadingAnimation(animation: AppAnimations.loading);
          default:
            return _body();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: AppStrings.registrarVenda,
      appBarColor: cashboost.AppColors.primaryColor,
      body: _bodyBuilder(),
      bottomNavigationBar: _buttonSave(),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
