import 'package:app_cashback_soamer/app_widget/consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/alterar_senha/alterar_senha_screen.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/form_field.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
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

  TextEditingController codeController = TextEditingController();

  void _checkCode() {
     if(codeController.text == widget.code) {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  AlterarSenhaScreen(email: widget.email)));
     } else {
       showSnackbarWarning(context, message: "Código Incorreto");
     }
  }

  Widget _body() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            SizedBox(height: 300, child: Image.network("https://www.signiflow.com/wp-content/uploads/2021/10/SigniFlow-application-security.png")),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: text("Enviamos um e-mail para ${widget.email}, confira sua caixa de entrada, spam ou promoções", textAlign: TextAlign.center, fontSize: 15),
            ),
            getPinCodeFormField(
              controller: codeController,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.grey.shade300,
              selectedFillColor: Colors.grey.shade100,
              activeColor: Colors.grey,
              selectedColor: Colors.grey.shade700,
              inactiveColor: Colors.grey.shade300,
            ),
            const SizedBox(height: 20),
            elevatedButtonText(
              "Verificar".toUpperCase(),
              width: MediaQuery.of(context).size.width - 30,
              color: AppColors.primaryColor,
              textColor: Colors.white,
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
      title: "Verificar código",
      body: _body(),
      hideBackArrow: true,
    );
  }
}
