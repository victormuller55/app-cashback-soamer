import 'package:app_cashback_soamer/app_widget/app_consts/app_animations.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart' as  cashboost;
import 'package:app_cashback_soamer/telas/recuperar_senha/alterar_senha/alterar_senha_screen.dart';
import 'package:flutter/material.dart';
import 'package:muller_package/muller_package.dart';

class VerificarCodigoScreen extends StatefulWidget {
  final String email;
  final String code;
  const VerificarCodigoScreen({super.key, required this.email, required this.code});

  @override
  State<VerificarCodigoScreen> createState() => _VerificarCodigoScreenState();
}

class _VerificarCodigoScreenState extends State<VerificarCodigoScreen> {

  late TextEditingController code = TextEditingController();

  void _checkCode() {
     if(code.text == widget.code) {
       open(screen: AlterarSenhaScreen(email: widget.email));
     } else {
       showSnackbarWarning(message: AppStrings.codigoIncorreto);
     }
  }

  Widget _body() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.normal),
        child: ListView(
          children: [
            appSizedBox(height:AppSpacing.big),
            appAnimation(AppAnimations.code, repete: false),
            Padding(
              padding: EdgeInsets.only(left: AppSpacing.normal, right: AppSpacing.normal, bottom: AppSpacing.big),
              child: appText("Enviamos um e-mail para ${widget.email}, confira sua caixa de entrada, spam ou promoções", textAlign: TextAlign.center, fontSize: AppFontSizes.normal),
            ),
            getPinCodeFormField(
              controller: code,
              activeFillColor:  cashboost.AppColors.white,
              inactiveFillColor:  cashboost.AppColors.grey300,
              selectedFillColor:  cashboost.AppColors.grey100,
              activeColor:  cashboost.AppColors.grey,
              selectedColor:  cashboost.AppColors.grey700,
              inactiveColor:  cashboost.AppColors.grey300,
            ),
            appSizedBox(height:AppSpacing.medium),
            appElevatedButtonText(
              AppStrings.verificar.toUpperCase(),
              width: MediaQuery.of(context).size.width - 30,
              color:  cashboost.AppColors.primaryColor,
              textColor:  cashboost.AppColors.white,
               function: () => _checkCode(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: AppStrings.verificarCodigo,
      appBarColor: cashboost.AppColors.primaryColor,
      body: _body(),
      hideBackIcon: true,
    );
  }
}
