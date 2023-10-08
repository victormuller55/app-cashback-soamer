import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/app_widget/form_field_formatters/form_field_formatter.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/app_widget/strings.dart';
import 'package:app_cashback_soamer/app_widget/validators/validators.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/functions/util.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/apresentacao/apresentacao_screen.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_bloc.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_event.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_state.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/form_field.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/sized_box.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditarPerfilScreen extends StatefulWidget {

  final UsuarioModel usuarioModel;
  const EditarPerfilScreen({super.key, required this.usuarioModel});

  @override
  State<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {

  CadastroBloc cadastroBloc = CadastroBloc();

  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerCPF = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  @override
  void initState() {
    controllerNome.text = widget.usuarioModel.nomeUsuario ?? "";
    controllerEmail.text = widget.usuarioModel.emailUsuario ?? "";
    controllerCPF.text = widget.usuarioModel.cpfUsuario ?? "";
    super.initState();
  }

  void _salvar() {
    UsuarioModel usuarioModel = UsuarioModel(
      idUsuario: widget.usuarioModel.idUsuario,
      nomeUsuario: controllerNome.text,
      emailUsuario: controllerEmail.text,
      cpfUsuario: controllerCPF.text.replaceAll(".", "").replaceAll("-", ""),
      senhaUsuario: controllerSenha.text,
    );

    cadastroBloc.add(CadastroSalvarEvent(usuarioModel));
  }

  void _validar() {
    if (verificaCampoVazio(controllers: [controllerNome.text, controllerEmail.text, controllerCPF.text, controllerSenha.text])) {
      if (emailValido(controllerEmail.text)) {
        if (cpfValido(controllerCPF.text)) {
          _salvar();
        } else {
          showSnackbarWarning(context, message: Strings.cpfInvalido);
        }
      } else {
        showSnackbarWarning(context, message: Strings.emailInvalido);
      }
    } else {
      showSnackbarWarning(context, message: Strings.todosOsCamposSaoObrigatorios);
    }
  }

  void _onChangeState(CadastroState state) {
    if (state is CadastroErrorState) showSnackbarError(context, message: state.errorModel.mensagem!.isEmpty ? "Ocorreu um erro, tente novamente mais tarde." : state.errorModel.mensagem);
    if (state is CadastroSuccessState) {
      open(context, screen: ApresentacaoScreen(usuarioModel: state.usuarioModel), closePrevious: true);
      saveLocalUserData(state.usuarioModel);
    }
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
            child: Center(child: text("Edite seus dados aqui, seu CPF não é possivel alterar.", bold: true, fontSize: 14, color: Colors.grey.shade600)),
          ),
          sizedBoxVertical(10),
          formFieldPadrao(context, controller: controllerNome, "Pedro Santana", width: 300, textInputType: TextInputType.name),
          sizedBoxVertical(10),
          formFieldPadrao(context, controller: controllerEmail, "pedrosantana@cashboost.com", width: 300, textInputType: TextInputType.emailAddress),
          sizedBoxVertical(10),
          formFieldPadrao(context, controller: controllerCPF, "322.123.543-98", width: 300, textInputType: TextInputType.number, textInputFormatter: FormFieldFormatter.cpfFormatter, enable: false),
          sizedBoxVertical(20),
          elevatedButtonText(
            "Salvar".toUpperCase(),
            color: AppColor.primaryColor,
            textColor: Colors.white,
            function: () => _validar(),
          ),
        ],
      ),
    );
  }

  Widget _bodyBuilder() {
    return BlocConsumer<CadastroBloc, CadastroState>(
      bloc: cadastroBloc,
      listener: (context, state) => _onChangeState(state),
      builder: (context, state) {
        switch (state.runtimeType) {
          case CadastroLoadingState:
            return loading(color: Colors.white);
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
}
