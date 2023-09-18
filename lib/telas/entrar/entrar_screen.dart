import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/app_widget/strings.dart';
import 'package:app_cashback_soamer/app_widget/validators/validators.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/functions/util.dart';
import 'package:app_cashback_soamer/telas/apresentacao/apresentacao_screen.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_screen.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_bloc.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_event.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_state.dart';
import 'package:app_cashback_soamer/telas/home/home_screen.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_screen.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/form_field.dart';
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
    }
    _focusScope.unfocus();
  }

  Widget _body() {
    return FocusScope(
      node: _focusScope,
      child: Column(
        children: [
          sizedBoxVertical(70),
          formFieldPadrao(context, controller: controllerEmail, Strings.email, width: 300, textInputType: TextInputType.emailAddress),
          formFieldPadrao(context, controller: controllerSenha, Strings.senha, width: 300, showSenha: false, textInputType: TextInputType.visiblePassword),
          sizedBoxVertical(20),
          GestureDetector(
            onTap: () => open(context, screen: const EnviarEmailScreen()),
            child: text(Strings.esqueciMinhaSenha, color: Colors.white, bold: true),
          ),
          sizedBoxVertical(35),
          _botaoCadastrarBloc(),
          sizedBoxVertical(10),
          elevatedButtonText(
            Strings.naoTenhoConta.toUpperCase(),
            transparente: true,
            function: () => open(context, screen: const CadastroScreen(), closePrevious: true),
          ),
          sizedBoxVertical(20),
        ],
      ),
    );
  }

  Widget _botaoCadastrarBloc() {
    return BlocConsumer<EntrarBloc, EntrarState>(
      bloc: bloc,
      listener: (context, state) => _onChangeState(state),
      builder: (context, state) => elevatedButtonPadrao(
        function: () => _validar(),
        state is EntrarLoadingState
            ? const CircularProgressIndicator()
            : text(
                Strings.cadastrar.toUpperCase(),
                color: AppColor.primaryColor,
                bold: true,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: backgroundCadastroLogin(context, child: _body()));
  }
}
