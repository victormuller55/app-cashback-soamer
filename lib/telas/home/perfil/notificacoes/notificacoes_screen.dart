import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificacoesScreen extends StatefulWidget {
  const NotificacoesScreen({super.key});

  @override
  State<NotificacoesScreen> createState() => _NotificacoesScreenState();
}

class _NotificacoesScreenState extends State<NotificacoesScreen> {

  bool switch1 = false;
  bool switch2 = false;
  bool switch3 = false;

  Widget _option(String titulo, {required bool valueSwitch}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        backgroundColor: Colors.grey.shade50,
        padding: const EdgeInsets.only(left: 10, right: 10),
        radius: BorderRadius.circular(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            text(titulo, color: Colors.grey, bold: true, fontSize: 13),
            CupertinoSwitch(value: valueSwitch, onChanged: (value) => setState(() => valueSwitch = !valueSwitch)),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return ListView(
      children: [
        _option("Receber notificações", valueSwitch: switch1),
        _option("Notificações de atualização", valueSwitch: switch2),
        _option("Notificações de pontos pendentes", valueSwitch: switch3),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: "Notificações",
      body: _body(),
    );
  }
}
