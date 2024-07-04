import 'package:app_cashback_soamer/app_widget/app_consts/app_animations.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_font_sizes.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_strings.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:app_cashback_soamer/telas/home/home_screen.dart';
import 'package:app_cashback_soamer/widgets/animations.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class ApresentacaoScreen extends StatefulWidget {
  final VendedorModel vendedorModel;

  const ApresentacaoScreen({super.key, required this.vendedorModel});

  @override
  State<ApresentacaoScreen> createState() => _ApresentacaoScreenState();
}

class _ApresentacaoScreenState extends State<ApresentacaoScreen> {

  TextStyle tituloStyle = TextStyle(fontSize: AppFontSizes.big, color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontFamily: 'lato');
  TextStyle descricaoStyle = TextStyle(fontSize: AppFontSizes.normal, color: AppColors.grey, fontFamily: 'lato');

  @override
  Widget build(BuildContext context) {
    List<PageViewModel> telas = [];

    telas.add(
      PageViewModel(
        title: AppStrings.tituloPresentacao1,
        body: AppStrings.descricaoapresentacao1,
        image: appAnimation(AppAnimations.apresentacao1, repete: false),
        decoration: PageDecoration(
          titleTextStyle: tituloStyle,
          bodyTextStyle: descricaoStyle,
        ),
      ),
    );

    telas.add(
      PageViewModel(
        title: AppStrings.tituloPresentacao2,
        body: AppStrings.descricaoapresentacao2,
        image: appAnimation(AppAnimations.apresentacao2, height: 280, repete: false),
        decoration: PageDecoration(
          titleTextStyle: tituloStyle,
          bodyTextStyle: descricaoStyle,
        ),
      ),
    );

    telas.add(
      PageViewModel(
        title: AppStrings.tituloPresentacao3,
        body: AppStrings.descricaoapresentacao3,
        image: appAnimation(AppAnimations.apresentacao3, height: 280, repete: false),
        decoration: PageDecoration(
          titleTextStyle: tituloStyle,
          bodyTextStyle: descricaoStyle,
        ),
      ),
    );

    telas.add(
      PageViewModel(
        title: AppStrings.tituloPresentacao4,
        body: AppStrings.descricaoapresentacao4,
        image: appAnimation(AppAnimations.apresentacao4, height: 280),
        decoration: PageDecoration(
          titleTextStyle: tituloStyle,
          bodyTextStyle: descricaoStyle,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.grey100,
      body: IntroductionScreen(
        globalBackgroundColor: AppColors.grey100,
        pages: telas,
        showBackButton: false,
        onDone: () => open(screen: HomeScreen(vendedorModel: widget.vendedorModel), closePrevious: true),
        showSkipButton: true,
        skip: appText(AppStrings.pular, bold: true, color: AppColors.grey, fontSize: AppFontSizes.small),
        next: appText(AppStrings.proximo.toUpperCase(), bold: true, color: AppColors.primaryColor, fontSize: AppFontSizes.small),
        done: appText(AppStrings.concluir.toUpperCase(), bold: true, color: AppColors.primaryColor, fontSize: AppFontSizes.small),
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
