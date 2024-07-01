import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/app_widget/strings.dart';
import 'package:app_cashback_soamer/app_widget/validators/validators.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/functions/util.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_screen.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_bloc.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_event.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_state.dart';
import 'package:app_cashback_soamer/telas/home/home_screen.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_screen.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/form_field.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/sized_box.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntrarScreen extends StatefulWidget {
  const EntrarScreen({super.key});

  @override
  State<EntrarScreen> createState() => _EntrarScreenState();
}

class _EntrarScreenState extends State<EntrarScreen> {
  EntrarBloc bloc = EntrarBloc();

  final FocusScopeNode _focusScope = FocusScopeNode();

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  void _validar() {
    if (verificaCampoVazio(controllers: [controllerEmail.text, controllerSenha.text])) {
      if (emailValido(controllerEmail.text)) {
        bloc.add(EntrarLoginEvent(controllerEmail.text, controllerSenha.text));
      } else {
        showSnackbarWarning(context, message: Strings.emailInvalido);
      }
    } else {
      showSnackbarWarning(context, message: Strings.todosOsCamposSaoObrigatorios);
    }
  }

  void _onChangeState(EntrarState state) {
    if (state is EntrarErrorState) showSnackbarError(context, message: state.errorModel.mensagem!.isEmpty ? Strings.ocorreuUmErro : state.errorModel.mensagem);
    if (state is EntrarSuccessState) {
      open(context, screen: HomeScreen(usuarioModel: state.usuarioModel), closePrevious: true);
      saveLocalUserData(state.usuarioModel);
      if(state.usuarioModel.nomeConcessionaria != null || state.usuarioModel.nomeConcessionaria != "") addLocalDataString("nome_concessionaria", state.usuarioModel.nomeConcessionaria ?? "");
    }
    _focusScope.unfocus();
  }

  Widget _body() {
    return FocusScope(
      node: _focusScope,
      child: Column(
        children: [
          appSizedBoxHeight(70),
          formFieldPadrao(context, controller: controllerEmail,  "E-mail", width: 300, textInputType: TextInputType.emailAddress),
          appSizedBoxHeight(10),
          formFieldPadrao(context, controller: controllerSenha, "Senha", width: 300, showSenha: false, textInputType: TextInputType.visiblePassword),
          appSizedBoxHeight(20),
          GestureDetector(
            onTap: () => open(context, screen: const EnviarEmailScreen()),
            child: text(Strings.esqueciMinhaSenha, color: Colors.white, bold: true),
          ),
          appSizedBoxHeight(35),
          elevatedButtonPadrao(
            function: () => _validar(),
            text("Entrar".toUpperCase(), color: AppColor.primaryColor, bold: true),
          ),
          appSizedBoxHeight(10),
          elevatedButtonText(
            Strings.naoTenhoConta.toUpperCase(),
            color: AppColor.primaryColor.withOpacity(0.5),
            textColor: Colors.white,
            function: () => open(context, screen: const CadastroScreen(), closePrevious: true),
          ),
          appSizedBoxHeight(20),
        ],
      ),
    );
  }

  Widget _bodyBuilder() {
    return BlocConsumer<EntrarBloc, EntrarState>(
      bloc: bloc,
      listener: (context, state) => _onChangeState(state),
      builder: (context, state) {
        switch (state.runtimeType) {
          case EntrarLoadingState:
            return loading(color: Colors.white);
          default:
            return _body();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: backgroundCadastroLogin(context, child: _bodyBuilder()));
  }
}
