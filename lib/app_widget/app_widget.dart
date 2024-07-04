import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_context.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:app_cashback_soamer/telas/apresentacao/apresentacao_screen.dart';
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

      VendedorModel vendedorModel = await getModelLocal();

      if (vendedorModel.id != null && !opened) {
        setState(() => screen = ApresentacaoScreen(vendedorModel: VendedorModel.empty()));
        // setState(() => screen = HomeScreen(vendedorModel: vendedorModel));
        opened = true;
      }

    }

    verificaLogin();

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primaryColor,
        useMaterial3: false,
      ),
      navigatorKey: AppContext.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: screen,
    );
  }
}
