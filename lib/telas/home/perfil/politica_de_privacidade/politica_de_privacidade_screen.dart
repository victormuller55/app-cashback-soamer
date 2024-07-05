import 'package:flutter/material.dart';
import 'package:muller_package/muller_package.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart' as cashboost;

class PoliticaDePrivacidadeScreen extends StatefulWidget {
  const PoliticaDePrivacidadeScreen({super.key});

  @override
  State<PoliticaDePrivacidadeScreen> createState() => _PoliticaDePrivacidadeScreenState();
}

class _PoliticaDePrivacidadeScreenState extends State<PoliticaDePrivacidadeScreen> {

  Widget _body() {
    return appContainer(
      child: Center(
        child: appText("Aqui vai a politica de privacidade"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      body: _body(),
      appBarBackground: cashboost.AppColors.primaryColor,
      title: AppStrings.politicasDePrivacidades,
    );
  }
}
