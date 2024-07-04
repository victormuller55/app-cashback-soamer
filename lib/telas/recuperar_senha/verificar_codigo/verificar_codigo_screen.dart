import 'package:app_cashback_soamer/app_widget/app_consts/app_animations.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_font_sizes.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_spacing.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_strings.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/alterar_senha/alterar_senha_screen.dart';
import 'package:app_cashback_soamer/widgets/animations.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/form_field.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/sized_box.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

class VerificarCodigoScreen extends StatefulWidget {
  final String email;
  final String code;
  const VerificarCodigoScreen({super.key, required this.email, required this.code});

  @override
  State<VerificarCodigoScreen> createState() => _VerificarCodigoScreenState();
}

class _VerificarCodigoScreenState extends State<VerificarCodigoScreen> {

  TextEditingController code = TextEditingController();

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
            appSizedBoxHeight(AppSpacing.big),
            appAnimation(AppAnimations.code, repete: false),
            Padding(
              padding: EdgeInsets.only(left: AppSpacing.normal, right: AppSpacing.normal, bottom: AppSpacing.big),
              child: appText("Enviamos um e-mail para ${widget.email}, confira sua caixa de entrada, spam ou promoções", textAlign: TextAlign.center, fontSize: AppFontSizes.normal),
            ),
            getPinCodeFormField(
              controller: code,
              activeFillColor: AppColors.white,
              inactiveFillColor: AppColors.grey300,
              selectedFillColor: AppColors.grey100,
              activeColor: AppColors.grey,
              selectedColor: AppColors.grey700,
              inactiveColor: AppColors.grey300,
            ),
            appSizedBoxHeight(AppSpacing.medium),
            appElevatedButtonText(
              AppStrings.verificar.toUpperCase(),
              width: MediaQuery.of(context).size.width - 30,
              color: AppColors.primaryColor,
              textColor: AppColors.white,
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
      body: _body(),
      hideBackArrow: true,
    );
  }
}
