import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/telas/registrar_venda/pdf_viewer/pdf_viewer_screen.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

class RegistrarVendaScreen extends StatefulWidget {
  const RegistrarVendaScreen({super.key});

  @override
  State<RegistrarVendaScreen> createState() => _RegistrarVendaScreenState();
}

class _RegistrarVendaScreenState extends State<RegistrarVendaScreen> {
  Widget _pdf() {
    return GestureDetector(
      onTap: () => open(context, screen: const MyApp()),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          backgroundColor: Colors.white,
          radius: BorderRadius.circular(10),
          child: Row(
            children: [
              container(
                height: 100,
                width: 100,
                backgroundColor: Colors.grey.shade300,
                radius: const BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
                child: const Center(child: Icon(Icons.document_scanner, color: Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("0000-0000-0000-0000-0000", bold: true, color: AppColor.primaryColor, fontSize: 17, overflow: true),
                    const SizedBox(height: 5),
                    text("00/00/0000 00:00", color: Colors.grey, overflow: true),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Hero(
            tag: "floatingButton",
            child: container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              backgroundColor: AppColor.primaryColor,
              radius: BorderRadius.circular(10),
              padding: const EdgeInsets.all(8),
              child: Center(
                child: text(
                  "Escolha o PDF que contem a ponteira soamer, após ser enviado os pontos podem levar de 1 a 3 dias uteis para os pontos cairem na sua conta pessoal.",
                  textAlign: TextAlign.center,
                  color: Colors.white,
                  bold: true,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                _pdf(),
                _pdf(),
                _pdf(),
                _pdf(),
                _pdf(),
                _pdf(),
                _pdf(),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: "Registrar venda",
      body: _body(),
    );
  }
}
