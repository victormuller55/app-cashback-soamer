import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/app_widget/validators/validators.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_bloc.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_event.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_state.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/verificar_codigo/verificar_codigo_screen.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/erro.dart';
import 'package:app_cashback_soamer/widgets/form_field.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnviarEmailScreen extends StatefulWidget {
  const EnviarEmailScreen({super.key});

  @override
  State<EnviarEmailScreen> createState() => _EnviarEmailScreenState();
}

class _EnviarEmailScreenState extends State<EnviarEmailScreen> {

  EnviarEmailBloc emailBloc = EnviarEmailBloc();
  TextEditingController controllerEmail = TextEditingController();

  void _enviarEmail() {
    if (controllerEmail.text.isNotEmpty) {
      if (emailValido(controllerEmail.text)) {
        emailBloc.add(EnviarEmailSendEvent(controllerEmail.text));
      } else {
        showSnackbarWarning(context, message: "E-mail inválido");
      }
    } else {
      showSnackbarWarning(context, message: "Preencha o campo.");
    }
  }

  void _onChangeState(EnviarEmailState state) {
    if (state.runtimeType == EnviarEmailSuccessState) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VerificarCodigoScreen(email: controllerEmail.text, code: state.code)));
    if (state.runtimeType == EnviarEmailSuccessState) showSnackbarSuccess(context, message: "E-mail enviado");
    if (state.runtimeType == EnviarEmailErrorState) showSnackbarError(context, message: state.errorModel.mensagem);
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          container(
            border: Border.all(color: AppColor.primaryColor),
            radius: BorderRadius.circular(10),
            padding: const EdgeInsets.all(10),
            backgroundColor: Colors.white,
            margin: const EdgeInsets.only(bottom: 10),
            child: text("Nós utilizaremos o seu e-mail como forma de provar que a conta é realmente sua, enviaremos uma mensagem com um código de recuperação ao e-mail digitado abaixo.", textAlign: TextAlign.center),
          ),
          formFieldPadrao(context, "Digite seu e-mail", controller: controllerEmail),
          const SizedBox(height: 10),
          elevatedButtonText(
            "Enviar Código".toUpperCase(),
            color: AppColor.primaryColor,
            textColor: Colors.white,
            function: () => _enviarEmail(),
          ),
        ],
      ),
    );
  }

  Widget _bodyBuilder() {
    return BlocConsumer<EnviarEmailBloc, EnviarEmailState>(
      bloc: emailBloc,
      listener: (context, state) => _onChangeState(state),
      builder: (context, state) {
        switch (state.runtimeType) {
          case EnviarEmailLoadingState:
            return loading();
          default:
            return _body();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(body: _bodyBuilder(), title: "Enviar e-mail");
  }
}
