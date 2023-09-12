import 'package:app_cashback_soamer/app_widget/strings.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_screen.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/form_field.dart';
import 'package:app_cashback_soamer/widgets/sized_box.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

class EntrarScreen extends StatefulWidget {
  const EntrarScreen({super.key});

  @override
  State<EntrarScreen> createState() => _EntrarScreenState();
}

class _EntrarScreenState extends State<EntrarScreen> {
  final FocusScopeNode _focusScope = FocusScopeNode();

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  Widget _body() {
    return FocusScope(
      node: _focusScope,
      child: Column(
        children: [
          sizedBoxVertical(70),
          formFieldPadrao(context, controller: controllerEmail, Strings.email, width: 300, textInputType: TextInputType.emailAddress),
          formFieldPadrao(context, controller: controllerSenha, Strings.senha, width: 300, showSenha: false, textInputType: TextInputType.visiblePassword),
          sizedBoxVertical(20),
          GestureDetector(
            onTap: () => {},
            child: text("Esqueci minha senha", color: Colors.white, bold: true),
          ),
          sizedBoxVertical(35),
          elevatedButtonPadrao(
            text("Entrar".toUpperCase(), color: const Color.fromRGBO(34, 111, 162, 1), bold: true),
            function: () => {},
          ),
          sizedBoxVertical(10),
          elevatedButtonText(
            "Não tenho conta".toUpperCase(),
            transparente: true,
            function: () => open(context, screen: const CadastroScreen(), closePrevious: true),
          ),
          sizedBoxVertical(20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: backgroundCadastroLogin(context, child: _body()));
  }
}
