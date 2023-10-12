import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/cupertino.dart';

class TermosDeUsoScreen extends StatefulWidget {
  const TermosDeUsoScreen({super.key});

  @override
  State<TermosDeUsoScreen> createState() => _TermosDeUsoScreenState();
}

class _TermosDeUsoScreenState extends State<TermosDeUsoScreen> {
  Widget _body() {
    return container(
      child: Center(
        child: text("Aqui vai a termos de uso"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      body: _body(),
      title: "Termos de uso",
    );
  }
}
