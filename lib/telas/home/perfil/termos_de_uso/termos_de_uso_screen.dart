import 'package:muller_package/muller_package.dart';
import 'package:flutter/material.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart' as cashboost;

class TermosDeUsoScreen extends StatefulWidget {
  const TermosDeUsoScreen({super.key});

  @override
  State<TermosDeUsoScreen> createState() => _TermosDeUsoScreenState();
}

class _TermosDeUsoScreenState extends State<TermosDeUsoScreen> {
  Widget _body() {
    return appContainer(
      child: Center(
        child: appText("Aqui vai a termos de uso"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      body: _body(),
      appBarColor: cashboost.AppColors.primaryColor,
      title: AppStrings.termosDeUso,
    );
  }
}
