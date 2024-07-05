import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart' as app;
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_screen.dart';
import 'package:app_cashback_soamer/telas/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:muller_package/muller_package.dart';


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
        setState(() => screen = HomeScreen(vendedorModel: vendedorModel));
        opened = true;
      }

    }

    verificaLogin();

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: app.AppColors.primaryColor,
        useMaterial3: false,
      ),
      navigatorKey: AppContext.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: screen,
    );
  }
}
