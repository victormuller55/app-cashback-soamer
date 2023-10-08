import 'package:app_cashback_soamer/app_widget/colors.dart';
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

  Widget _body() {
    return ListView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: text("ENVIAR EMAIL",bold: true),
      ),
      body: _body()
    );
  }
}
