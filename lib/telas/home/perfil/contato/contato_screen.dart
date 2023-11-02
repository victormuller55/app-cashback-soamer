import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContatoSoamer extends StatefulWidget {
  const ContatoSoamer({super.key});

  @override
  State<ContatoSoamer> createState() => _ContatoSoamerState();
}

class _ContatoSoamerState extends State<ContatoSoamer> {
  void _launchURL(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao abrir a URL: $e');
      }
    }
  }

  Widget _option(String titulo, IconData icon, {required void Function() function}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: GestureDetector(
        onTap: function,
        child: container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          backgroundColor: Colors.grey.shade50,
          padding: const EdgeInsets.only(left: 10, right: 10),
          radius: BorderRadius.circular(20),
          child: ListTile(
            leading: Icon(icon, color: AppColor.primaryColor),
            title: text(titulo, color: Colors.grey, bold: true, fontSize: 14),
            trailing: const Icon(Icons.launch),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: ListView(
        children: [
          _option("Ligar para (41) 3056-7777", Icons.phone, function: () => _launchURL("tel:+554130567777")),
          _option("E-mail para contato@ponteirasoamer.com.br", Icons.email, function: () => _launchURL("mailto:contato@ponteirasoamer.com.br")),
          _option("WhatsApp (41) 3056-7777", Icons.phone, function: () => _launchURL("whatsapp://send?phone=4130567777")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: "Contato Soamer",
      body: _body(),
    );
  }
}
