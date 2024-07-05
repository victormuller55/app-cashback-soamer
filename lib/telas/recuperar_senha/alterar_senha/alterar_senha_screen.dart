import 'package:app_cashback_soamer/app_widget/app_consts/app_animations.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart' as cashboost;
import 'package:app_cashback_soamer/telas/recuperar_senha/alterar_senha/alterar_senha_bloc.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/alterar_senha/alterar_senha_event.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/alterar_senha/alterar_senha_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muller_package/muller_package.dart';

class AlterarSenhaScreen extends StatefulWidget {
  final String email;

  const AlterarSenhaScreen({super.key, required this.email});

  @override
  State<AlterarSenhaScreen> createState() => _AlterarSenhaScreenState();
}

class _AlterarSenhaScreenState extends State<AlterarSenhaScreen> {

  AlterarSenhaBloc bloc = AlterarSenhaBloc();

  TextEditingController senha = TextEditingController();
  TextEditingController confirmarSenha = TextEditingController();

  void _entrarESalvar() {
   if(senha.text.isNotEmpty && confirmarSenha.text.isNotEmpty) {
     if (senha.text == confirmarSenha.text) {
       bloc.add(AlterarSenhaEnviarEvent(widget.email, senha.text));
     } else {
       showSnackbarWarning(message: AppStrings.asSenhasNaoSaoIguais);
     }
   } else {
     showSnackbarWarning(message: AppStrings.preenchaTodosOsCampos);
   }
  }

  Widget _body() {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.normal),
      child: ListView(
        children: [
          appFormField(context, hint: AppStrings.digiteSuaNovaSenha, showSenha: false, controller: senha),
          appSizedBox(height:AppSpacing.normal),
          appFormField(context, hint: AppStrings.confirmeSuaNovaSenha, showSenha: false, controller: confirmarSenha),
          appSizedBox(height:AppSpacing.normal),
          appElevatedButtonText(
            AppStrings.salvarEEntrar.toUpperCase(),
            function: () => _entrarESalvar(),
            color: cashboost.AppColors.primaryColor,
            textColor: cashboost.AppColors.white,
          )
        ],
      ),
    );
  }

  Widget _bodyBuilder() {
    return BlocBuilder<AlterarSenhaBloc, AlterarSenhaState>(
      bloc: bloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case AlterarSenhaLoadingState:
            return appLoadingAnimation(animation: AppAnimations.loading);
          case AlterarSenhaErrorState:
            return appError(state.errorModel, function: () => _entrarESalvar());
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
      title: AppStrings.alterarSenha,
      hideBackArrow: true,
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
