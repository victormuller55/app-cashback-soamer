import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/home/home_screen.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

class ApresentacaoScreen extends StatefulWidget {
  UsuarioModel usuarioModel;
  ApresentacaoScreen({super.key, required this.usuarioModel});

  @override
  State<ApresentacaoScreen> createState() => _ApresentacaoScreenState();
}

class _ApresentacaoScreenState extends State<ApresentacaoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: text("APRESENTAÇÃO",bold: true),
      ),
      body: Center(child: elevatedButtonText("PRÓXIMA PAGINA", function: () => open(context, screen: HomeScreen(usuarioModel: widget.usuarioModel), closePrevious: true))),
    );
  }
}
