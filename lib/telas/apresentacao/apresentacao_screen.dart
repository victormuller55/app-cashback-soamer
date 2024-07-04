import 'package:app_cashback_soamer/app_widget/consts/app_animations.dart';
import 'package:app_cashback_soamer/app_widget/consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/consts/app_font_sizes.dart';
import 'package:app_cashback_soamer/app_widget/consts/app_strings.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/home/home_screen.dart';
import 'package:app_cashback_soamer/widgets/animations.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class ApresentacaoScreen extends StatefulWidget {
  final VendedorModel usuarioModel;

  const ApresentacaoScreen({super.key, required this.usuarioModel});

  @override
  State<ApresentacaoScreen> createState() => _ApresentacaoScreenState();
}

class _ApresentacaoScreenState extends State<ApresentacaoScreen> {
  @override
  Widget build(BuildContext context) {

    List<PageViewModel> telas = [];

    telas.add(
      PageViewModel(
        title: AppStrings.tituloPresentacao1,
        body: AppStrings.descricaoapresentacao1,
        image: animacao(AppAnimations.apresentacao1),
      ),
    );

    telas.add(
      PageViewModel(
        title: AppStrings.tituloPresentacao2,
        body: AppStrings.descricaoapresentacao2,
        image: animacao(AppAnimations.apresentacao2),
      ),
    );

    telas.add(
      PageViewModel(
        title: AppStrings.tituloPresentacao3,
        body: AppStrings.descricaoapresentacao3,
        image: animacao(AppAnimations.apresentacao3),
      ),
    );

    telas.add(
      PageViewModel(
        title: AppStrings.tituloPresentacao4,
        body: AppStrings.descricaoapresentacao4,
        image: animacao(AppAnimations.apresentacao4),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.grey100,
      body: IntroductionScreen(
        globalBackgroundColor: AppColors.grey100,
        pages: telas,
        showBackButton: false,
        onDone: () => open(screen: HomeScreen(usuarioModel: widget.usuarioModel), closePrevious: true),
        showSkipButton: true,
        skip: text(AppStrings.pular, bold: true, color: AppColors.grey, fontSize: AppFontSizes.small),
        next: text(AppStrings.proximo.toUpperCase(), bold: true, color: AppColors.primaryColor, fontSize: AppFontSizes.small),
        done: text(AppStrings.concluir.toUpperCase(), bold: true, color: AppColors.primaryColor, fontSize: AppFontSizes.small),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: AppColors.primaryColor,
          color: Colors.black,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
