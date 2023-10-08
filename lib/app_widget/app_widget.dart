import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_screen.dart';
import 'package:app_cashback_soamer/telas/home/home_screen.dart';
import 'package:flutter/material.dart';

Widget screen = const CadastroScreen();
bool opened = false;

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {

    verificaLogin() async {
      UsuarioModel usuarioModel = await getModelLocal();
      if (usuarioModel.idUsuario != null && !opened) {
        setState(() => screen = HomeScreen(usuarioModel: usuarioModel));
        opened = true;
      }
    }

    verificaLogin();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: screen,
      theme: ThemeData(scaffoldBackgroundColor: AppColor.primaryColor),
    );
  }
}
