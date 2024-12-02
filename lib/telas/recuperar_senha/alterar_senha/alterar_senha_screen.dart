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

  late AppFormField senha;
  late AppFormField confirmarSenha;

  @override
  void initState() {

    senha = AppFormField(
      context: context,
      hint: AppStrings.digiteSuaNovaSenha,
      showContent: false,
    );

    confirmarSenha = AppFormField(
      context: context,
      hint: AppStrings.digiteSuaNovaSenha,
      showContent: false,
    );

    super.initState();
  }

  void _entrarESalvar() {
    if (senha.controller.text.isNotEmpty && confirmarSenha.controller.text.isNotEmpty) {
      if (senha.controller.text == confirmarSenha.controller.text) {
        bloc.add(AlterarSenhaEnviarEvent(widget.email, senha.controller.text));
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
          senha.formulario,
          appSizedBox(height: AppSpacing.normal),
          confirmarSenha.formulario,
          appSizedBox(height: AppSpacing.normal),
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
      appBarColor: cashboost.AppColors.primaryColor,
      title: AppStrings.alterarSenha,
      hideBackIcon: true,
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
