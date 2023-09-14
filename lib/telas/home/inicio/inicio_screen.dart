import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/widgets/circular_avatar.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

class InicioScreen extends StatefulWidget {

  UsuarioModel usuarioModel;
  InicioScreen({super.key, required this.usuarioModel});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  Widget _cardInfo({required String title, required String value}) {
    return container(
      radius: BorderRadius.circular(10),
      backgroundColor: Colors.grey.shade300,
      width: MediaQuery.of(context).size.width / 2.2,
      height: 100,
      child: infoColumn(
        title: value,
        value: title,
        titleSize: 30,
        valueSize: 15,
        titleColor: AppColor.primaryColor,
        valueColor: Colors.grey.shade600,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  Widget _body() {
    return ListView(
      children: [
        container(
          height: MediaQuery.of(context).size.height / 6,
          backgroundColor: AppColor.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  avatar("https://lh3.googleusercontent.com/a/ACg8ocJHMHXUyO6Qn3Be26X2J-eDQDIAYRsfHAxg_GrenujeBwc=s96-c-rg-br100"),
                  const SizedBox(width: 20),
                  infoColumn(
                    title: widget.usuarioModel.nomeUsuario ?? "",
                    value: "Lamborghini",
                    width: MediaQuery.of(context).size.width / 3,
                    spacing: true,
                  ),
                ],
              ),
              infoColumn(
                title: widget.usuarioModel.pontosUsuario.toString(),
                value: "Pontos",
                titleSize: 30,
                valueSize: 15,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _cardInfo(value: widget.usuarioModel.pontosPendentesUsuario.toString(), title: "Pontos pendentes"),
            _cardInfo(value: "R\$${widget.usuarioModel.pontosUsuario},00", title: "Em pix"),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: text("Inicio".toUpperCase(), bold: true),
      ),
      body: _body(),
    );
  }
}
