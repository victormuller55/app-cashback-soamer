import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class RegistrarVendaScreen extends StatefulWidget {
  const RegistrarVendaScreen({super.key});

  @override
  State<RegistrarVendaScreen> createState() => _RegistrarVendaScreenState();
}

class _RegistrarVendaScreenState extends State<RegistrarVendaScreen> {
  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Hero(
            tag: "floatingButton",
            child: elevatedButtonText(
              "Enviar venda".toUpperCase(),
              color: AppColor.primaryColor,
              textColor: Colors.white,
              function: () => Navigator.pop(context),
              width: MediaQuery.of(context).size.width,
            ),
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(body: _body(), title: "Registrar venda");
  }
}
