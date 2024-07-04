import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_spacing.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_strings.dart';
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
import 'package:app_cashback_soamer/widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          appSizedBoxHeight(AppSpacing.normal),
          appFormField(context, hint: AppStrings.confirmeSuaNovaSenha, showSenha: false, controller: confirmarSenha),
          appSizedBoxHeight(AppSpacing.normal),
          appElevatedButtonText(
            AppStrings.salvarEEntrar.toUpperCase(),
            function: () => _entrarESalvar(),
            color: AppColors.primaryColor,
            textColor: AppColors.white,
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
            return loadingAnimation();
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
