import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';
import 'package:app_cashback_soamer/telas/home/inicio/inicio_bloc.dart';
import 'package:app_cashback_soamer/telas/home/inicio/inicio_event.dart';
import 'package:app_cashback_soamer/telas/home/inicio/inicio_state.dart';
import 'package:app_cashback_soamer/widgets/circular_avatar.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/erro.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/modal.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InicioScreen extends StatefulWidget {
  final UsuarioModel usuarioModel;

  const InicioScreen({super.key, required this.usuarioModel});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  InicioBloc bloc = InicioBloc();
  bool carregou = false;

  Future<void> loadHome() async {
    bloc.add(InicioLoadEvent(widget.usuarioModel.emailUsuario!));
    carregou = true;
  }

  @override
  void initState() {
    loadHome();
    super.initState();
  }

  void _showModelConcessionaria() {
    showModalEmpty(
      context,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          text("Qual das concessionaria abaixo você trabalha?", bold: true, fontSize: 15),
        ],
      )
    );
  }

  Widget _cardInfo({required String title, required String value}) {
    return GestureDetector(
      onTap: () => _showModelConcessionaria(),
      child: container(
        radius: BorderRadius.circular(10),
        backgroundColor: Colors.grey.shade300,
        width: MediaQuery.of(context).size.width / 2.2,
        height: 100,
        child: infoColumn(
          title: value,
          value: title,
          titleSize: 25,
          valueSize: 13,
          titleColor: AppColor.primaryColor,
          valueColor: Colors.grey.shade600,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
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
            titleSize: 25,
            valueSize: 13,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ],
      ),
    );
  }

  void _onChangeState(InicioState state) {
    if (state is InicioSuccessState && carregou) {
      bloc.add(LoadVaucherPromocaoEvent(state.homeModel));
      carregou = false;
    }
  }

  Widget _body(InicioState homeState) {
    List<Widget> cardsPromocao = [];
    cardsPromocao.add(const SizedBox(width: 10));

    for (VaucherModel model in homeState.vaucherListPromocao) {
      cardsPromocao.add(cardVaucher(model));
    }

    return RefreshIndicator(
      onRefresh: loadHome,
      child: ListView(
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
            child: text("Vauchers na promoção!", bold: true, color: AppColor.primaryColor, fontSize: 14),
          ),
          SizedBox(
            height: 180,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: cardsPromocao,
            ),
          ),
        ],
      ),
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
    return scaffold(
      body: _bodyBuilder(),
      title: "Inicio",
      hideBackArrow: true,
    );
  }
}
