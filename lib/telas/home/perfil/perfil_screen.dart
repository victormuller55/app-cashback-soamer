import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_font_sizes.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_icons.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_radius.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_spacing.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_strings.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_screen.dart';
import 'package:app_cashback_soamer/telas/home/perfil/contato/contato_screen.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_screen.dart';
import 'package:app_cashback_soamer/telas/home/perfil/politica_de_privacidade/politica_de_privacidade_screen.dart';
import 'package:app_cashback_soamer/telas/home/perfil/termos_de_uso/termos_de_uso_screen.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/erro.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/modal.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/sized_box.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {

  Future<VendedorModel> _loadDataLocal() async {
    return await getModelLocal();
  }

  @override
  void initState() {
    _loadDataLocal();
    super.initState();
  }

  void _sair() {
    showModalEmpty(
      context,
      height: 210,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          appSizedBoxHeight(AppSpacing.medium),
          appText(AppStrings.voceRealmenteDesejaSairDaConta, bold: true, fontSize: AppFontSizes.normal, color: AppColors.grey600),
          appSizedBoxHeight(AppSpacing.medium),
          appElevatedButtonText(AppStrings.simSairDaConta.toUpperCase(), function: () => _exit(), width: MediaQuery.of(context).size.width, color: AppColors.red, textColor: AppColors.white),
          appSizedBoxHeight(AppSpacing.normal),
          appElevatedButtonText(AppStrings.naoCancelar.toUpperCase(), function: () => Navigator.pop(context), width: MediaQuery.of(context).size.width),
          appSizedBoxHeight(AppSpacing.normal),
        ],
      ),
    );
  }

  void _exit() {
    clearLocalData();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CadastroScreen()));
  }

  Widget _option(String titulo, {required void Function() onTap, bool? closeAccount}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: AppSpacing.small),
        child: appContainer(
          height: 50,
          width: MediaQuery.of(context).size.width,
          backgroundColor: closeAccount ?? false ? AppColors.red : AppColors.grey100,
          padding: EdgeInsets.only(left: AppSpacing.big, right: AppSpacing.big),
          radius: BorderRadius.circular(AppRadius.normal),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              appText(titulo, color: closeAccount ?? false ? AppColors.white : AppColors.grey600, bold: false, fontSize: AppFontSizes.normal),
              Icon(AppIcons.arrowRight, color: closeAccount ?? false ? AppColors.white : AppColors.grey, size: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(VendedorModel vendedorModel) {
    return appContainer(
      height: 140,
      width: MediaQuery.of(context).size.width,
      backgroundColor: AppColors.white,
      padding: EdgeInsets.only(
        top: AppSpacing.normal,
        bottom: AppSpacing.normal,
        left: AppSpacing.medium,
        right: AppSpacing.normal,
      ),
      radius: BorderRadius.circular(AppRadius.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appText(
                vendedorModel.nome ?? AppStrings.vazio,
                bold: true,
                fontSize: AppFontSizes.medium,
                color: AppColors.primaryColor,
              ),
              appSizedBoxHeight(AppSpacing.normal),
              appText(
                vendedorModel.nomeConcessionaria ?? AppStrings.vazio,
                bold: true,
                fontSize: AppFontSizes.small,
                color: AppColors.grey600,
              ),
              appSizedBoxHeight(AppSpacing.normal),
              appElevatedButtonText(
                AppStrings.editarPerfil.toUpperCase(),
                function: () => open(screen: EditarPerfilScreen(vendedorModel: vendedorModel)),
                width: 200,
                height: 45,
                borderRadius: AppRadius.normal,
                color: AppColors.primaryColor,
                textColor: AppColors.white,
              ),
            ],
          ),
          Hero(
            tag: "usuario",
            child: appContainer(
              height: 120,
              width: 120,
              radius: BorderRadius.circular(AppRadius.normal),
              border: Border.all(color: AppColors.primaryColor, width: 2),
              image: NetworkImage(AppEndpoints.endpointImageVendedor(vendedorModel.id!)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(VendedorModel vendedorModel) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.normal),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          _header(vendedorModel),
          appSizedBoxHeight(AppSpacing.normal),
          appContainer(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(AppSpacing.normal),
            radius: BorderRadius.circular(AppRadius.medium),
            backgroundColor: AppColors.white,
            child: Column(
              children: [
                _option(AppStrings.termosDeUso, onTap: () => open(screen: const TermosDeUsoScreen())),
                _option(AppStrings.politicasDePrivacidades, onTap: () => open(screen: const PoliticaDePrivacidadeScreen())),
                _option(AppStrings.contatoSoamer, onTap: () => open(screen: const ContatoSoamer())),
                _option(AppStrings.sairDaConta, onTap: () => _sair(), closeAccount: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: AppStrings.meuPerfil,
      body: FutureBuilder(
        future: _loadDataLocal(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loading();
          }

          if (snapshot.hasError) {
            return erro(ErrorModel(mensagem: AppStrings.ocorreuUmErro), function: () => _loadDataLocal());
          }

          return _body(snapshot.data!);
        },
      ),
      hideBackArrow: true,
    );
  }
}
