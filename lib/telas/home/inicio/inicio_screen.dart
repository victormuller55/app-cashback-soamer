import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/app_widget/strings.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';
import 'package:app_cashback_soamer/telas/home/inicio/inicio_bloc.dart';
import 'package:app_cashback_soamer/telas/home/inicio/inicio_event.dart';
import 'package:app_cashback_soamer/telas/home/inicio/inicio_state.dart';
import 'package:app_cashback_soamer/widgets/circular_avatar.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/erro.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InicioScreen extends StatefulWidget {
  UsuarioModel usuarioModel;

  InicioScreen({super.key, required this.usuarioModel});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  InicioBloc bloc = InicioBloc();
  bool carregou = false;

  void loadHome() {
    bloc.add(InicioLoadEvent(widget.usuarioModel.emailUsuario!));
    carregou = true;
  }

  @override
  void initState() {
    loadHome();
    super.initState();
  }

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

  Widget _header(InicioState homeState) {
    return container(
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
                title: widget.usuarioModel.nomeUsuario!,
                value: "Lamborghini",
                width: MediaQuery.of(context).size.width / 3,
                spacing: true,
              ),
            ],
          ),
          infoColumn(
            title: homeState.homeModel.pontosUsuario.toString(),
            value: "Pontos",
            titleSize: 30,
            valueSize: 15,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ],
      ),
    );
  }

  void _onChangeState(InicioState state) {
    if (state is InicioErrorState) showSnackbarError(context, message: state.errorModel.mensagem!.isEmpty ? Strings.ocorreuUmErro : state.errorModel.mensagem);
    if (state is InicioSuccessState && carregou == true) {
      bloc.add(LoadVaucherPromocaoEvent());
      carregou = false;
    }
  }

  Widget _body(InicioState homeState) {
    List<Widget> cards = [];

    for (VaucherModel vaucherModel in homeState.vaucherList) {
      cards.add(cardVaucher(vaucherModel));
    }

    return ListView(
      children: [
        _header(homeState),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _cardInfo(value: homeState.homeModel.pontosPedentesUsuario.toString(), title: "Pontos pendentes"),
            _cardInfo(value: "R\$${homeState.homeModel.valorPix},00", title: "Em pix"),
          ],
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 6),
          child: text("Vauchers na promoção!", bold: true, color: AppColor.primaryColor, fontSize: 17),
        ),
        SizedBox(
          height: 180,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: cards,
          ),
        ),
      ],
    );
  }

  Widget _bodyBuilder() {
    return BlocConsumer<InicioBloc, InicioState>(
      bloc: bloc,
      listener: (context, state) => _onChangeState(state),
      builder: (context, state) {
        switch (state.runtimeType) {
          case InicioLoadingState:
            return loading();
          case InicioSuccessState:
            return _body(state);
          case InicioErrorState:
            return erro(state.errorModel, function: () => loadHome());
          default:
            return container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: text("Inicio".toUpperCase(), bold: true),
      ),
      body: _bodyBuilder(),
    );
  }
}
