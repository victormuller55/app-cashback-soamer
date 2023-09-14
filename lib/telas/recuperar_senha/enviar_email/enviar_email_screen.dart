import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/verificar_codigo/verificar_codigo_screen.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

class EnviarEmailScreen extends StatefulWidget {
  const EnviarEmailScreen({super.key});

  @override
  State<EnviarEmailScreen> createState() => _EnviarEmailScreenState();
}

class _EnviarEmailScreenState extends State<EnviarEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: text("ENVIAR EMAIL",bold: true),
      ),
      body: Center(child: elevatedButtonText("PRÓXIMA PAGINA", function: () => open(context, screen: const VerificarCodigoScreen()))),
    );
  }
}
