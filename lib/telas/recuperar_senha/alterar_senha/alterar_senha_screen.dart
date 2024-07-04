import 'package:app_cashback_soamer/app_widget/consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/telas/home/home_screen.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/alterar_senha/alterar_senha_bloc.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/alterar_senha/alterar_senha_event.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/alterar_senha/alterar_senha_state.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/erro.dart';
import 'package:app_cashback_soamer/widgets/form_field.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlterarSenhaScreen extends StatefulWidget {
  final String email;

  const AlterarSenhaScreen({super.key, required this.email});

  @override
  State<AlterarSenhaScreen> createState() => _AlterarSenhaScreenState();
}

class _AlterarSenhaScreenState extends State<AlterarSenhaScreen> {
  AlterarSenhaBloc alterarSenhaBloc = AlterarSenhaBloc();

  TextEditingController senha = TextEditingController();
  TextEditingController confirmarSenha = TextEditingController();

  void _entrarESalvar() {
   if(senha.text.isNotEmpty && confirmarSenha.text.isNotEmpty) {
     if (senha.text == confirmarSenha.text) {
       alterarSenhaBloc.add(AlterarSenhaEnviarEvent(widget.email, senha.text));
     } else {
       showSnackbarWarning(context, message: "As senha não são iguais");
     }
   } else {
     showSnackbarWarning(context, message: "Preencha todos os camps");
   }
  }

  void _onChangeState(AlterarSenhaState state) {
    if (state is AlterarSenhaSuccessState) {
      open(context, screen: HomeScreen(usuarioModel: state.usuarioModel), closePrevious: true);
      saveLocalUserData(state.usuarioModel);
      if (state.usuarioModel.nomeConcessionaria != null || state.usuarioModel.nomeConcessionaria != "") addLocalDataString("nome_concessionaria", state.usuarioModel.nomeConcessionaria ?? "");
    }
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          formFieldPadrao(context, "Digite sua nova senha", showSenha: false, controller: senha),
          const SizedBox(height: 10),
          formFieldPadrao(context, "Confirme sua nova senha", showSenha: false, controller: confirmarSenha),
          const SizedBox(height: 10),
          elevatedButtonText(
            "Salvar e entrar".toUpperCase(),
            function: () => _entrarESalvar(),
            color: AppColors.primaryColor,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }

  Widget _bodyBuilder() {
    return BlocConsumer<AlterarSenhaBloc, AlterarSenhaState>(
      bloc: alterarSenhaBloc,
      listener: (context, state) => _onChangeState(state),
      builder: (context, state) {
        switch (state.runtimeType) {
          case AlterarSenhaLoadingState:
            return loading();
          case AlterarSenhaErrorState:
            return erro(state.errorModel, function: () => _entrarESalvar());
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
      title: "Alterar senha",
      hideBackArrow: true,
    );
  }
}
