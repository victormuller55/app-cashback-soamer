import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/home/home_screen.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class ApresentacaoScreen extends StatefulWidget {
  final UsuarioModel usuarioModel;

  const ApresentacaoScreen({super.key, required this.usuarioModel});

  @override
  State<ApresentacaoScreen> createState() => _ApresentacaoScreenState();
}

class _ApresentacaoScreenState extends State<ApresentacaoScreen> {
  @override
  Widget build(BuildContext context) {
    List<PageViewModel> screens = [];

    screens.add(
      PageViewModel(
        title: "SEJA BEM-VINDO",
        body: "Bem-vindo ao aplicativo da SOAMER ponteiras automotivas, esse aplicativo tem como objetivo distribuir cashback a vendedores das ponteiras SOAMER.",
        image: Image.network("https://www.indianautoexchange.com/assets/images/dealerImage.png", height: 170.0),
      ),
    );

    screens.add(
      PageViewModel(
        title: "PONTOS E MAIS PONTOS",
        body: "Ao escanear o código de barras da NFE após a venda de uma ponteira SOAMER, você ganha pontos no aplicativo!",
        image: Image.network("https://static.vecteezy.com/system/resources/previews/020/968/350/non_2x/qr-code-scan-free-png.png", height: 220.0),
      ),
    );

    screens.add(
      PageViewModel(
        title: "ESPERE UM POUCO!",
        body: "Após a leitura do código, basta esperar o nosso time validar os pontos em até 72h, após isso, você ja pode gastar seus pontos como quiser. ",
        image: Image.network("https://spacesinc.app/assets/images/Office%20Workers%20Sitting%20At%20Desks.png", height: 260.0),
      ),
    );

    screens.add(
      PageViewModel(
        title: "VOUCHERS E PIX!",
        body: "Você pode gastar seus pontos trocando por vouchers, ou se preferir receber um PIX direto na sua conta!",
        image: Image.network("https://cdni.iconscout.com/illustration/premium/thumb/gift-coupon-4500808-3748802.png", height: 220.0),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: IntroductionScreen(
        globalBackgroundColor: Colors.grey.shade100,
        pages: screens,
        showBackButton: false,
        onDone: () => Future.delayed(Duration.zero).then((value) => open(context, screen: HomeScreen(usuarioModel: widget.usuarioModel), closePrevious: true)),
        showSkipButton: true,
        skip: text("Pular", bold: true, color: Colors.grey, fontSize: 16),
        next: text("Proximo".toUpperCase(), bold: true, color: AppColor.primaryColor, fontSize: 16),
        done: text("Concluir".toUpperCase(), bold: true, color: AppColor.primaryColor, fontSize: 16),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: AppColor.primaryColor,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
