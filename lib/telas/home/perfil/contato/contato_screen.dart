import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_font_sizes.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_icons.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_radius.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_spacing.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_strings.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContatoSoamer extends StatefulWidget {
  const ContatoSoamer({super.key});

  @override
  State<ContatoSoamer> createState() => _ContatoSoamerState();
}

class _ContatoSoamerState extends State<ContatoSoamer> {
  void _abrirLink(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      showSnackbarError(message: AppStrings.naoFoiPossivelAbrirOLink);
    }
  }

  Widget _option(String titulo, IconData icon, {required void Function() function}) {
    return Padding(
      padding: EdgeInsets.only(top: AppSpacing.small),
      child: GestureDetector(
        onTap: function,
        child: appContainer(
          height: 60,
          width: MediaQuery.of(context).size.width,
          backgroundColor: AppColors.grey50,
          padding: EdgeInsets.only(left: AppSpacing.normal, right: AppSpacing.normal),
          radius: BorderRadius.circular(AppRadius.normal),
          child: ListTile(
            leading: Icon(icon, color: AppColors.primaryColor),
            title: appText(titulo, color: AppColors.grey, bold: true, fontSize: AppFontSizes.small),
            trailing: const Icon(AppIcons.link),
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
          _option("Ligar (41) 3056-7777", AppIcons.phone, function: () => _abrirLink("tel:+554130567777")),
          _option("contato@ponteirasoamer.com.br", AppIcons.email, function: () => _abrirLink("mailto:contato@ponteirasoamer.com.br")),
          _option("WhatsApp (41) 3056-7777", AppIcons.phone, function: () => _abrirLink("whatsapp://send?phone=4130567777")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: AppStrings.contatoSoamer,
      body: _body(),
    );
  }
}
