import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

class VerificarCodigoScreen extends StatefulWidget {
  const VerificarCodigoScreen({super.key});

  @override
  State<VerificarCodigoScreen> createState() => _VerificarCodigoScreenState();
}

class _VerificarCodigoScreenState extends State<VerificarCodigoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: text("VERIFICAR CÓDIGO",bold: true),
      ),
      body: Center(child: elevatedButtonText("PRÓXIMA PAGINA", function: () => open(context, screen: Container()))),
    );
  }
}
