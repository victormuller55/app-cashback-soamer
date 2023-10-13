import 'dart:io';
import 'dart:ui';

import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/app_widget/endpoints.dart';
import 'package:app_cashback_soamer/app_widget/form_field_formatters/form_field_formatter.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/app_widget/strings.dart';
import 'package:app_cashback_soamer/app_widget/validators/validators.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/util.dart';
import 'package:app_cashback_soamer/models/edit_usuario_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_bloc.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_event.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_state.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/erro.dart';
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
  final UsuarioModel usuarioModel;

  const EditarPerfilScreen({super.key, required this.usuarioModel});

  @override
  State<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  EditarUsuarioBloc editarUsuarioBloc = EditarUsuarioBloc();
  File imageFile = File("");

  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerCPF = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  TextEditingController controllerNovaSenha = TextEditingController();

  @override
  void initState() {
    controllerNome.text = widget.usuarioModel.nomeUsuario ?? "";
    controllerEmail.text = widget.usuarioModel.emailUsuario ?? "";
    controllerCPF.text = widget.usuarioModel.cpfUsuario ?? "";
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
      nome: controllerNome.text == widget.usuarioModel.nomeUsuario ? "" : controllerNome.text,
      email: widget.usuarioModel.emailUsuario,
      newEmail: controllerEmail.text == widget.usuarioModel.emailUsuario ? "" : controllerEmail.text,
      senha: controllerSenha.text,
      newSenha: controllerNovaSenha.text,
    );

    editarUsuarioBloc.add(EditarUsuarioSalvarEvent(usuarioModel, imageFile));
  }

  void _validar() {
    if (verificaCampoVazio(controllers: [controllerNome.text, controllerEmail.text, controllerCPF.text, controllerSenha.text])) {
      if (emailValido(controllerEmail.text)) {
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
                      color: AppColor.primaryColor,
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
        children: [
          container(
            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
            backgroundColor: Colors.grey.shade300,
            radius: BorderRadius.circular(10),
            child: Center(
              child: text(
                "Edite seus dados aqui, seu CPF não é possivel alterar.",
                bold: true,
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          sizedBoxVertical(10),
          Column(
            children: [
              Hero(
                tag: "usuario",
                child: imageFile.path.isEmpty
                    ? container(
                        height: 150,
                        width: 150,
                        radius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.primaryColor, width: 2),
                        image: NetworkImage(Endpoint.endpointImageUsuario(widget.usuarioModel.idUsuario!)),
                      )
                    : container(
                        height: 150,
                        width: 150,
                        radius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.primaryColor, width: 2),
                        image: FileImage(imageFile),
                      ),
              ),
              sizedBoxVertical(10),
              elevatedButtonText(
                "Escolher foto".toUpperCase(),
                function: () => pickImage(),
                width: 200,
                height: 45,
                borderRadius: 10,
                color: AppColor.primaryColor,
                textColor: Colors.white,
              ),
            ],
          ),
          sizedBoxVertical(10),
          formFieldPadrao(context, controller: controllerNome, "Pedro Santana", width: 300, textInputType: TextInputType.name),
          sizedBoxVertical(10),
          formFieldPadrao(context, controller: controllerEmail, "pedrosantana@cashboost.com", width: 300, textInputType: TextInputType.emailAddress),
          sizedBoxVertical(10),
          formFieldPadrao(context, controller: controllerCPF, "322.123.543-98", width: 300, textInputType: TextInputType.number, textInputFormatter: FormFieldFormatter.cpfFormatter, enable: false),
          sizedBoxVertical(10),
          formFieldPadrao(context, controller: controllerNovaSenha, "Digite sua nova senha", width: 300, textInputType: TextInputType.visiblePassword, showSenha: false),
          sizedBoxVertical(10),
          elevatedButtonText(
            "Salvar".toUpperCase(),
            color: AppColor.primaryColor,
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
          case EditarUsuarioErrorState:
            return erro(state.errorModel, function: () => {});
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
