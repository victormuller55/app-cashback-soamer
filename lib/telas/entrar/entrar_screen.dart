import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_spacing.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_strings.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/app_widget/validators/validators.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/functions/util.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_screen.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_bloc.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_event.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_state.dart';
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

  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();

  void _validar() {
    if (verificaCampoFormVazio(controllers: [email, senha])) {
      if (validaEmail(email.text)) {
        bloc.add(EntrarLoginEvent(email.text, senha.text));
      } else {
        showSnackbarWarning(message: AppStrings.emailInvalido);
      }
    } else {
      showSnackbarWarning(message: AppStrings.todosOsCamposSaoObrigatorios);
    }
  }

  Widget _body() {
    return Column(
      children: [
        appSizedBoxHeight(70),
        formFieldPadrao(context, controller: email, hint: AppStrings.email, width: 300, textInputType: TextInputType.emailAddress),
        formFieldPadrao(context, controller: senha,hint: AppStrings.senha, width: 300, showSenha: false, textInputType: TextInputType.visiblePassword),
        appSizedBoxHeight(AppSpacing.medium),
        GestureDetector(
          onTap: () => open(screen: const EnviarEmailScreen()),
          child: appText(AppStrings.esqueciMinhaSenha, color: AppColors.white, bold: true),
        ),
        appSizedBoxHeight(35),
        elevatedButtonPadrao(
          function: () => _validar(),
          appText(AppStrings.entrar.toUpperCase(), color: AppColors.primaryColor, bold: true),
        ),
        appSizedBoxHeight(AppSpacing.normal),
        elevatedButtonText(
          AppStrings.naoTenhoConta.toUpperCase(),
          color: AppColors.primaryColor.withOpacity(0.5),
          textColor: AppColors.white,
          function: () => open(screen: const CadastroScreen(), closePrevious: true),
        ),
        appSizedBoxHeight(AppSpacing.medium),
      ],
    );
  }

  Widget _bodyBuilder() {
    return BlocBuilder<EntrarBloc, EntrarState>(
      bloc: bloc,
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
    return Scaffold(
      body: backgroundCadastroLogin(
        context,
        child: _bodyBuilder(),
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
