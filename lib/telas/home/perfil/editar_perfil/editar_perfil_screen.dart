import 'dart:io';

import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_bloc.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_event.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_state.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_animations.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart' as cashboost;
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';
import 'package:app_cashback_soamer/models/edit_vendedor_model.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muller_package/muller_package.dart';

class EditarPerfilScreen extends StatefulWidget {
  final VendedorModel vendedorModel;

  const EditarPerfilScreen({super.key, required this.vendedorModel});

  @override
  State<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  EditarVendedorBloc bloc = EditarVendedorBloc();
  File imageFile = File("");

  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController celular = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController senha = TextEditingController();
  TextEditingController novaSenha = TextEditingController();

  @override
  void initState() {
    nome.text = widget.vendedorModel.nome ?? AppStrings.vazio;
    email.text = widget.vendedorModel.email ?? AppStrings.vazio;
    cpf.text = formataCPF(widget.vendedorModel.cpf ?? "");
    celular.text = formataCelular(widget.vendedorModel.celular.toString());
    super.initState();
  }

  void _imagemGaleria() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() => imageFile = File(image.path));
      }
    } catch (e) {
      showSnackbarError(message: AppStrings.naoEPossivelAbrirAGaleria);
    }
  }

  void _salvar() {
    EditVendedorModel vendedorModel = EditVendedorModel(
      nome: nome.text,
      email: email.text,
      celular: celular.text,
      newEmail: email.text,
      senha: senha.text,
      newSenha: novaSenha.text,
    );

    bloc.add(EditarVendedorSalvarEvent(vendedorModel, imageFile));
  }

  void _validar() {
    if (verificaCampoFormVazio(controllers: [nome, email, cpf, senha])) {
      if (validaEmail(email.text)) {
        _salvar();
      } else {
        showSnackbarWarning(message: AppStrings.emailInvalido);
      }
    } else {
      showSnackbarWarning(message: AppStrings.todosOsCamposSaoObrigatorios);
    }
  }

  void _pedirSenhaModel() {
    showModalEmpty(
      context,
      isDismissible: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          appContainer(
            width: MediaQuery.of(context).size.width,
            radius: BorderRadius.circular(AppRadius.normal),
            padding: EdgeInsets.all(AppSpacing.medium),
            height: 60,
            backgroundColor: cashboost.AppColors.grey700,
            child: appText(
              AppStrings.digiteSuaSenhaEditarDados,
              textAlign: TextAlign.center,
              color: Colors.white,
              bold: true,
            ),
          ),
          appFormField(
            context,
            hint: AppStrings.senha,
            controller: senha,
            showSenha: false,
            width: MediaQuery.of(context).size.width,
          ),
          appSizedBox(height: AppSpacing.normal),
          appElevatedButtonText(
            AppStrings.salvar.toUpperCase(),
            width: MediaQuery.of(context).size.width,
            borderRadius: AppRadius.normal,
            function: () {
              _validar();
              Navigator.pop(context);
            },
            color: cashboost.AppColors.primaryColor,
            textColor: Colors.white,
          ),
          appSizedBox(height: AppSpacing.normal),
          appElevatedButtonText(
            AppStrings.cancelar.toUpperCase(),
            borderRadius: AppRadius.normal,
            width: MediaQuery.of(context).size.width,
            function: () {
              Navigator.pop(context);
            },
            color: cashboost.AppColors.red,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.normal),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          appSizedBox(height: AppSpacing.normal),
          appContainer(
            padding: EdgeInsets.all(AppSpacing.normal),
            radius: BorderRadius.circular(AppRadius.medium),
            backgroundColor: cashboost.AppColors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    appContainer(
                      width: MediaQuery.of(context).size.width * 0.50,
                      height: 90,
                      padding: EdgeInsets.all(AppSpacing.normal),
                      backgroundColor: cashboost.AppColors.grey300,
                      radius: BorderRadius.circular(AppRadius.normal),
                      child: Center(
                        child: appText(
                          AppStrings.mensagensEditarDados,
                          fontSize: AppFontSizes.normal,
                          color: Colors.grey.shade600,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    appSizedBox(height: AppSpacing.normal),
                    appElevatedButtonText(
                      AppStrings.alterarFoto.toUpperCase(),
                      function: () => _imagemGaleria(),
                      width: MediaQuery.of(context).size.width * 0.50,
                      height: 45,
                      borderRadius: AppRadius.normal,
                      color: cashboost.AppColors.primaryColor,
                      textColor: Colors.white,
                    ),
                  ],
                ),
                Hero(
                  tag: "usuario",
                  child: imageFile.path.isEmpty
                      ? appContainer(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.width * 0.35,
                          radius: BorderRadius.circular(AppRadius.normal),
                          border: Border.all(color: cashboost.AppColors.primaryColor, width: 2),
                          image: NetworkImage(AppEndpoints.endpointImageVendedor(widget.vendedorModel.id!)),
                        )
                      : appContainer(
                          height: 150,
                          width: 150,
                          radius: BorderRadius.circular(AppRadius.normal),
                          border: Border.all(color: cashboost.AppColors.primaryColor, width: 2),
                          image: FileImage(imageFile),
                        ),
                ),
                appSizedBox(height: AppSpacing.normal),
              ],
            ),
          ),
          appFormField(context, controller: nome, hint: AppStrings.nome, width: 300, textInputType: TextInputType.name),
          appFormField(context, controller: email, hint: AppStrings.email, width: 300, textInputType: TextInputType.emailAddress),
          appFormField(context, controller: celular, hint: AppStrings.celular, width: 300, textInputType: TextInputType.number, textInputFormatter: AppFormFormatters.phoneFormatter),
          appFormField(context, controller: cpf, hint: AppStrings.cpf, width: 300, textInputType: TextInputType.number, textInputFormatter: AppFormFormatters.cpfFormatter, enable: false),
          appFormField(context, controller: novaSenha, hint: AppStrings.novaSenha, width: 300, textInputType: TextInputType.visiblePassword, showSenha: false),
          appSizedBox(height: AppSpacing.medium),
          appElevatedButtonText(
            AppStrings.salvar.toUpperCase(),
            color: cashboost.AppColors.primaryColor,
            textColor: cashboost.AppColors.white,
            borderRadius: AppRadius.normal,
            function: () => _pedirSenhaModel(),
          ),
        ],
      ),
    );
  }

  Widget _bodyBuilder() {
    return BlocBuilder<EditarVendedorBloc, EditarVendedorState>(
      bloc: bloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case EditarVendedorLoadingState:
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
      body: _bodyBuilder(),
      appBarBackground: cashboost.AppColors.primaryColor,
      title: AppStrings.editarPerfil,
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
