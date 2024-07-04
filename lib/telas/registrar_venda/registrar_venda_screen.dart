import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_font_sizes.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_form_formatter.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_radius.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_spacing.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_strings.dart';
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

class _RegistrarVendaScreenState extends State<RegistrarVendaScreen> {
  RegistrarVendaBloc bloc = RegistrarVendaBloc();
  TextEditingController nota = TextEditingController();

  int selected = -1;

  void _save() {
    if (nota.text.isNotEmpty) {
      if (selected != -1) {
        return bloc.add(RegistrarVendaLoadEvent(nota.text, selected));
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
          color: AppColors.primaryColor,
          textColor: AppColors.white,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  Future<void> scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#FFFFFF', AppStrings.cancelar, false, ScanMode.BARCODE);

    if (barcodeScanRes != '-1') {
      return setState(() => nota.text = barcodeScanRes);
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
        backgroundColor: selected == index ? AppColors.primaryColor : AppColors.grey300,
        radius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: selected == index ? AppColors.primaryColor : AppColors.grey300, width: 3),
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
              backgroundColor: selected == index ? AppColors.primaryColor : Colors.grey.shade300,
              width: 160,
            ),
            appSizedBoxHeight(AppSpacing.small),
            appText(nome, color: selected == index ? Colors.white : Colors.grey),
            appSizedBoxHeight(AppSpacing.small),
            appText(
              nome.contains("dupla") ? "+20 Pontos" : "+ 10 Pontos",
              color: selected == index ? AppColors.white : AppColors.grey,
              bold: true,
              fontSize: AppFontSizes.normal,
            ),
            appSizedBoxHeight(AppSpacing.small),
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
          appSizedBoxHeight(AppSpacing.normal),
          appFormField(
            context,
            hint: AppStrings.digiteONumeroDaNFE,
            textInputFormatter: AppFormFormatters.nfeFormatter,
            textInputType: TextInputType.number,
            controller: nota,
          ),
          appSizedBoxHeight(AppSpacing.normal),
          appText(AppStrings.ou, textAlign: TextAlign.center, bold: true, color: AppColors.primaryColor),
          appSizedBoxHeight(AppSpacing.normal),
          appElevatedButtonText(
            AppStrings.escanearCodigo.toUpperCase(),
            function: () => scanBarcode(),
            color: AppColors.primaryColor,
            textColor: AppColors.white,
            width: MediaQuery.of(context).size.width,
          ),
          const Divider(),
          appContainer(
            backgroundColor: AppColors.grey300,
            radius: BorderRadius.circular(AppRadius.normal),
            padding: EdgeInsets.all(AppSpacing.normal),
            child: appText(AppStrings.selecioneAPonteiraVendida, textAlign: TextAlign.center),
          ),
          appSizedBoxHeight(AppSpacing.medium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ponteiras(0, "black_piano_dupla.jpg", AppStrings.blackPianoDupla),
              _ponteiras(1, "black_piano_simples.jpg", AppStrings.blackPianoSimples),
            ],
          ),
          appSizedBoxHeight(AppSpacing.medium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ponteiras(2, "polida_dupla.jpg", AppStrings.polidaDupla),
              _ponteiras(3, "polida_simples.jpg", AppStrings.polidaSimples),
            ],
          ),
          appSizedBoxHeight(AppSpacing.medium),
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
            return loadingAnimation();
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
