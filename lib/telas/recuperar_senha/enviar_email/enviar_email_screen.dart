import 'package:app_cashback_soamer/app_widget/app_consts/app_animations.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart' as cashboost;
import 'package:app_cashback_soamer/app_widget/validators/validators.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_bloc.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_event.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muller_package/muller_package.dart';

class EnviarEmailScreen extends StatefulWidget {
  const EnviarEmailScreen({super.key});

  @override
  State<EnviarEmailScreen> createState() => _EnviarEmailScreenState();
}

class _EnviarEmailScreenState extends State<EnviarEmailScreen> {

  EnviarEmailBloc bloc = EnviarEmailBloc();
  TextEditingController email = TextEditingController();

  void _enviarEmail() {
    if (email.text.isNotEmpty) {
      if (validaEmail(email.text)) {
        bloc.add(EnviarEmailSendEvent(email.text));
      } else {
        showSnackbarWarning(message: AppStrings.emailInvalido);
      }
    } else {
      showSnackbarWarning(message: AppStrings.preechaOCampo);
    }
  }


  Widget _body() {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.normal),
      child: ListView(
        children: [
          appContainer(
            border: Border.all(color: cashboost.AppColors.primaryColor),
            radius: BorderRadius.circular(AppRadius.normal),
            padding:  EdgeInsets.all(AppSpacing.normal),
            backgroundColor:  cashboost.AppColors.white,
            margin: EdgeInsets.only(bottom: AppSpacing.normal),
            child: appText(AppStrings.mensagemEmail, textAlign: TextAlign.center),
          ),
          appFormField(context, hint: AppStrings.email, controller: email),
          appSizedBox(height:AppSpacing.normal),
          appElevatedButtonText(
            AppStrings.enviarCodigo.toUpperCase(),
            color:  cashboost.AppColors.primaryColor,
            textColor:  cashboost.AppColors.white,
            function: () => _enviarEmail(),
          ),
        ],
      ),
    );
  }

  Widget _bodyBuilder() {
    return BlocBuilder<EnviarEmailBloc, EnviarEmailState>(
      bloc: bloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case EnviarEmailLoadingState:
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
      title: AppStrings.enviarEmail,
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
