import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

class PoliticaDePrivacidadeScreen extends StatefulWidget {
  const PoliticaDePrivacidadeScreen({super.key});

  @override
  State<PoliticaDePrivacidadeScreen> createState() => _PoliticaDePrivacidadeScreenState();
}

class _PoliticaDePrivacidadeScreenState extends State<PoliticaDePrivacidadeScreen> {

  Widget _body() {
    return container(
      child: Center(
        child: text("Aqui vai a politica de privacidade"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      body: _body(),
      title: "POLITICA DE PRIVACIDADE",
    );
  }
}
