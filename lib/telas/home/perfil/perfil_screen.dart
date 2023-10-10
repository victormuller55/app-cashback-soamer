import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/functions/formatters.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_screen.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_screen.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/erro.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/modal.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {

  Future<UsuarioModel> _loadDataLocal() async {
    return await getModelLocal();
  }

  @override
  void initState() {
    _loadDataLocal();
    super.initState();
  }

  void _sair() {
    showModalEmpty(
      context,
      height: 210,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 20),
          text("Você realmete deseja sair da conta?", bold: true, fontSize: 15, color: Colors.grey.shade600),
          const SizedBox(height: 20),
          elevatedButtonText("Sim, sair da conta".toUpperCase(), function: () => _exit(), width: MediaQuery.of(context).size.width, color: Colors.red, textColor: Colors.white),
          const SizedBox(height: 10),
          elevatedButtonText("Não, Cancelar".toUpperCase(), function: () => Navigator.pop(context), width: MediaQuery.of(context).size.width),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _exit() {
    clearLocalData();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CadastroScreen()));
  }

  Widget _option(String titulo, {required void Function() onTap, bool? closeAccount}) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          backgroundColor: closeAccount ?? false ? Colors.red : Colors.grey.shade50,
          padding: const EdgeInsets.only(left: 10, right: 10),
          radius: BorderRadius.circular(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(titulo, color: closeAccount ?? false ? Colors.white : Colors.grey, bold: true, fontSize: 13),
              Icon(Icons.arrow_forward_ios_sharp, color: closeAccount ?? false ? Colors.white : Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(UsuarioModel usuarioModel) {
    return container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      backgroundColor: Colors.white,
      radius: BorderRadius.circular(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(usuarioModel.nomeConcessionaria ?? "", bold: true, fontSize: 14, color: AppColor.primaryColor),
              const SizedBox(height: 7),
              text(formatarCPF(usuarioModel.cpfUsuario ?? ""), bold: true, fontSize: 15, color: Colors.grey.shade600),
              const SizedBox(height: 10),
              elevatedButtonText(
                "Editar perfil".toUpperCase(),
                function: () => open(context, screen: EditarPerfilScreen(usuarioModel: usuarioModel)),
                width: 200,
                height: 45,
                borderRadius: 10,
                color: AppColor.primaryColor,
                textColor: Colors.white,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              container(height: 90, width: 90, radius: BorderRadius.circular(10), border: Border.all(color: AppColor.primaryColor, width: 2), image: const NetworkImage("https://st3.depositphotos.com/9998432/13335/v/450/depositphotos_133352156-stock-illustration-default-placeholder-profile-icon.jpg")),
              const SizedBox(height: 7),
              text(usuarioModel.nomeUsuario ?? "", bold: true, fontSize: 13, color: AppColor.primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _body(UsuarioModel usuarioModel) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          _header(usuarioModel),
          const SizedBox(height: 10),
          container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            radius: BorderRadius.circular(10),
            backgroundColor: Colors.white,
            child: Column(
              children: [
                _option("Notificações", onTap: () => {}),
                _option("Termos de uso", onTap: () => {}),
                _option("Politica de privacidade", onTap: () => {}),
                _option("Contato Soamer", onTap: () => {}),
                _option("Sair da conta", onTap: () => _sair(), closeAccount: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: text("Meu perfil".toUpperCase(), bold: true),
      ),
      body: FutureBuilder(
        future: _loadDataLocal(),
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting) {
            return loading();
          }

          if(snapshot.hasError) {
            return erro(ErrorModel(mensagem: "Ocorreu um erro ao carregar os dados de perfil"), function: () => _loadDataLocal());
          }

          return _body(snapshot.data!);
        },
      ),
    );
  }
}
