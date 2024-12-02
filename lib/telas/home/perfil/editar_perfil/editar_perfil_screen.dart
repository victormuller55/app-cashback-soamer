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

  late AppFormField nome ;
  late AppFormField email ;
  late AppFormField celular ;
  late AppFormField cpf ;
  late AppFormField senha ;
  late AppFormField novaSenha ;

  @override
  void initState() {

    nome = AppFormField(
      context: context,
      hint: AppStrings.nome,
      width: 300,
      textInputType: TextInputType.name,
    );

    email = AppFormField(
      context: context,
      hint: AppStrings.email,
      width: 300,
      textInputType: TextInputType.emailAddress,
    );

    celular = AppFormField(
      context: context,
      hint: AppStrings.celular,
      width: 300,
      textInputType: TextInputType.number,
      textInputFormatter: AppFormFormatters.phoneFormatter,
    );

    cpf = AppFormField(
      context: context,
      hint: AppStrings.cpf,
      width: 300,
      textInputType: TextInputType.number,
      textInputFormatter: AppFormFormatters.cpfFormatter,
    );

    cpf = AppFormField(
      context: context,
      hint: AppStrings.senha,
      width: 300,
      textInputType: TextInputType.visiblePassword,
    );

    nome.controller.text = widget.vendedorModel.nome ?? AppStrings.vazio;
    email.controller.text = widget.vendedorModel.email ?? AppStrings.vazio;
    cpf.controller.text = formataCPF(widget.vendedorModel.cpf ?? "");
    celular.controller.text = formataCelular(widget.vendedorModel.celular.toString());

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
      nome: nome.controller.text,
      email: email.controller.text,
      celular: celular.controller.text,
      newEmail: email.controller.text,
      senha: senha.controller.text,
      newSenha: novaSenha.controller.text,
    );

    bloc.add(EditarVendedorSalvarEvent(vendedorModel, imageFile));
  }

  void _validar() {
    if (verificaCampoFormVazio(controllers: [nome.controller, email.controller, cpf.controller, senha.controller])) {
      if (validaEmail(email.controller.text)) {
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
          senha.formulario,
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
          nome.formulario,
          email.formulario,
          celular.formulario,
          cpf.formulario,
          novaSenha.formulario,
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
      appBarColor: cashboost.AppColors.primaryColor,
      title: AppStrings.editarPerfil,
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
