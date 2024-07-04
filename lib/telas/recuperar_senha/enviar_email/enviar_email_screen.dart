import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_radius.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_spacing.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_strings.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/app_widget/validators/validators.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_bloc.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_event.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_state.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/verificar_codigo/verificar_codigo_screen.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/form_field.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/sized_box.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            border: Border.all(color: AppColors.primaryColor),
            radius: BorderRadius.circular(AppRadius.normal),
            padding:  EdgeInsets.all(AppSpacing.normal),
            backgroundColor: AppColors.white,
            margin: EdgeInsets.only(bottom: AppSpacing.normal),
            child: appText(AppStrings.mensagemEmail, textAlign: TextAlign.center),
          ),
          appFormField(context, hint: AppStrings.email, controller: email),
          appSizedBoxHeight(AppSpacing.normal),
          appElevatedButtonText(
            AppStrings.enviarCodigo.toUpperCase(),
            color: AppColors.primaryColor,
            textColor: AppColors.white,
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
            return loadingAnimation();
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
      title: AppStrings.enviarEmail,
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
