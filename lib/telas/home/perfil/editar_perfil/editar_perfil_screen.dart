import 'dart:io';
import 'dart:ui';

import 'package:app_cashback_soamer/app_widget/consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/app_endpoints.dart';
import 'package:app_cashback_soamer/app_widget/consts/app_form_formatter.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/app_widget/app_strings.dart';
import 'package:app_cashback_soamer/app_widget/validators/validators.dart';
import 'package:app_cashback_soamer/functions/formatters.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/util.dart';
import 'package:app_cashback_soamer/models/edit_usuario_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_bloc.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_event.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_state.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/form_field.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/sized_box.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditarPerfilScreen extends StatefulWidget {
  final VendedorModel usuarioModel;

  const EditarPerfilScreen({super.key, required this.usuarioModel});

  @override
  State<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  EditarUsuarioBloc editarUsuarioBloc = EditarUsuarioBloc();
  File imageFile = File("");

  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerCelular = TextEditingController();
  TextEditingController controllerCPF = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  TextEditingController controllerNovaSenha = TextEditingController();

  @override
  void initState() {
    controllerNome.text = widget.usuarioModel.nome ?? "";
    controllerEmail.text = widget.usuarioModel.email ?? "";
    controllerCPF.text = widget.usuarioModel.cpf ?? "";
    controllerCelular.text = formataCelular(widget.usuarioModel.celular.toString());
    super.initState();
  }

  void pickImage() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() => imageFile = File(image.path));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      showSnackbarError(context, message: "Não é possivel abrir a galeria");
    }
  }

  void _salvar() {
    EditUsuarioModel usuarioModel = EditUsuarioModel(
      nome: controllerNome.text == widget.usuarioModel.nome ? "" : controllerNome.text,
      email: widget.usuarioModel.email,
      celular: widget.usuarioModel.celular,
      newEmail: controllerEmail.text == widget.usuarioModel.email ? "" : controllerEmail.text,
      senha: controllerSenha.text,
      newSenha: controllerNovaSenha.text,
    );

    editarUsuarioBloc.add(EditarUsuarioSalvarEvent(usuarioModel, imageFile));
  }

  void _validar() {
    if (verificaCampoFormVazio(controllers: [controllerNome.text, controllerEmail.text, controllerCPF.text, controllerSenha.text])) {
      if (validaEmail(controllerEmail.text)) {
        _salvar();
      } else {
        showSnackbarWarning(context, message: Strings.emailInvalido);
      }
    } else {
      showSnackbarWarning(context, message: Strings.todosOsCamposSaoObrigatorios);
    }
  }

  void _onChangeState(EditarUsuarioState state) {
    if (state is EditarUsuarioErrorState) showSnackbarError(context, message: state.errorModel.mensagem!.isEmpty ? "Ocorreu um erro, tente novamente mais tarde." : state.errorModel.mensagem);
    if (state is EditarUsuarioSuccessState) {
      saveLocalUserData(state.usuarioModel);
      Navigator.pop(context);
      showSnackbarSuccess(context, message: "Salvo com sucesso");
    }
  }

  void _askPasswordPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: container(
              radius: BorderRadius.circular(20),
              height: 190,
              width: 240,
              backgroundColor: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    container(
                      radius: BorderRadius.circular(10),
                      padding: const EdgeInsets.all(8),
                      backgroundColor: Colors.grey.shade700,
                      child: text("Digite sua senha para a alteração dos dados da conta, por favor.", textAlign: TextAlign.center, color: Colors.white, bold: true),
                    ),
                    formFieldPadrao(context, "Digite sua senha", controller: controllerSenha, showSenha: false),
                    elevatedButtonText(
                      "SALVAR",
                      function: () {
                        _validar();
                        Navigator.pop(context);
                      },
                      color: AppColors.primaryColor,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          appSizedBoxHeight(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  container(
                    width: 200,
                    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                    backgroundColor: Colors.grey.shade300,
                    radius: BorderRadius.circular(20),
                    child: Center(
                      child: text(
                        "É possível fazer alterações nos dados do usuário, com exceção do número de CPF.",
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  elevatedButtonText(
                    "Alterar foto".toUpperCase(),
                    function: () => pickImage(),
                    width: 200,
                    height: 45,
                    borderRadius: 30,
                    color: AppColors.primaryColor,
                    textColor: Colors.white,
                  ),
                ],
              ),
              Hero(
                tag: "usuario",
                child: imageFile.path.isEmpty
                    ? container(
                        height: 150,
                        width: 150,
                        radius: BorderRadius.circular(20),
                        // border: Border.all(color: AppColor.primaryColor, width: 2),
                        image: NetworkImage(AppEndpoints.endpointImageUsuario(widget.usuarioModel.id!)),
                      )
                    : container(
                        height: 150,
                        width: 150,
                        radius: BorderRadius.circular(20),
                        // border: Border.all(color: AppColor.primaryColor, width: 2),
                        image: FileImage(imageFile),
                      ),
              ),
              appSizedBoxHeight(10),

            ],
          ),
          appSizedBoxHeight(10),
          formFieldPadrao(context, controller: controllerNome, "Nome", width: 300, textInputType: TextInputType.name),
          appSizedBoxHeight(10),
          formFieldPadrao(context, controller: controllerEmail, "E-mail", width: 300, textInputType: TextInputType.emailAddress),
          appSizedBoxHeight(10),
          formFieldPadrao(context, controller: controllerCelular, "Celular", width: 300, textInputType: TextInputType.number, textInputFormatter: AppFormFormatters.phoneFormatter),
          appSizedBoxHeight(10),
          formFieldPadrao(context, controller: controllerCPF, "CPF", width: 300, textInputType: TextInputType.number, textInputFormatter: AppFormFormatters.cpfFormatter, enable: false),
          appSizedBoxHeight(10),
          formFieldPadrao(context, controller: controllerNovaSenha, "Digite sua nova senha", width: 300, textInputType: TextInputType.visiblePassword, showSenha: false),
          appSizedBoxHeight(10),
          elevatedButtonText(
            "Salvar".toUpperCase(),
            color: AppColors.primaryColor,
            textColor: Colors.white,
            function: () => {_askPasswordPopup()},
          ),
        ],
      ),
    );
  }

  Widget _bodyBuilder() {
    return BlocConsumer<EditarUsuarioBloc, EditarUsuarioState>(
      bloc: editarUsuarioBloc,
      listener: (context, state) => _onChangeState(state),
      builder: (context, state) {
        switch (state.runtimeType) {
          case EditarUsuarioLoadingState:
            return loading();
          default:
            return _body();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(body: _bodyBuilder(), title: "Editar perfil");
  }

  @override
  void dispose() {
    editarUsuarioBloc.close();
    super.dispose();
  }
}
