import 'package:app_cashback_soamer/app_widget/app_consts/app_animations.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart' as cashboost;
import 'package:app_cashback_soamer/app_widget/validators/validators.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_screen.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_bloc.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_event.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_state.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_screen.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muller_package/muller_package.dart';

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
        appSizedBox(height:70),
        appFormField(context, controller: email, hint: AppStrings.email, width: 300, textInputType: TextInputType.emailAddress),
        appFormField(context, controller: senha,hint: AppStrings.senha, width: 300, showSenha: false, textInputType: TextInputType.visiblePassword),
        appSizedBox(height:AppSpacing.medium),
        GestureDetector(
          onTap: () => open(screen: const EnviarEmailScreen()),
          child: appText(AppStrings.esqueciMinhaSenha, color: AppColors.white, bold: true),
        ),
        appSizedBox(height:35),
        appElevatedButton(
          function: () => _validar(),
          appText(AppStrings.entrar.toUpperCase(), color: cashboost.AppColors.primaryColor, bold: true),
        ),
        appSizedBox(height:AppSpacing.normal),
        appElevatedButtonText(
          AppStrings.naoTenhoConta.toUpperCase(),
          color: cashboost.AppColors.primaryColor.withOpacity(0.5),
          textColor: cashboost.AppColors.white,
          function: () => open(screen: const CadastroScreen(), closePrevious: true),
        ),
        appSizedBox(height:AppSpacing.medium),
      ],
    );
  }

  Widget _bodyBuilder() {
    return BlocBuilder<EntrarBloc, EntrarState>(
      bloc: bloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case EntrarLoadingState:
            return appLoading(child: loadingCircular(), color: Colors.white);
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
