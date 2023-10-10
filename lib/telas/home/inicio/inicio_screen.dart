import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/concessionaria_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';
import 'package:app_cashback_soamer/telas/home/inicio/inicio_bloc.dart';
import 'package:app_cashback_soamer/telas/home/inicio/inicio_event.dart';
import 'package:app_cashback_soamer/telas/home/inicio/inicio_state.dart';
import 'package:app_cashback_soamer/widgets/circular_avatar.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/elevated_button.dart';
import 'package:app_cashback_soamer/widgets/erro.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/modal.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  InicioBloc bloc = InicioBloc();
  bool salvouConcessionaria = false;

  @override
  void initState() {
    _loadConcessionaria();
    _loadHome();
    super.initState();
  }

  void _saveConcessionaria(ConcessionariaModel value) {
    bloc.add(SetConcessionariaEvent(value.idConcessionaria!));
    addLocalDataString("nome_concessionaria", value.nomeConcessionaria!);
    salvouConcessionaria = true;
    Navigator.pop(context);
    _loadHome();
  }

  Future<void> _loadHome() async {
    UsuarioModel usuarioModel = await getModelLocal();
    bloc.add(InicioLoadEvent(usuarioModel.emailUsuario!));
  }

  void _loadConcessionaria() async {
    UsuarioModel usuarioModel = await getModelLocal();
    if (usuarioModel.nomeConcessionaria == null || usuarioModel.nomeConcessionaria == "") {
      bloc.add(LoadConcessionariaEvent());
    }
  }

  void _showModalConcessionaria(InicioState inicioState) {
    List<DropdownMenuItem<ConcessionariaModel>> list = [];

    for (ConcessionariaModel concessionariaModel in inicioState.concessionariaList) {
      list.add(_menuItem(concessionariaModel));
    }

    ConcessionariaModel dropdownValue = inicioState.concessionariaList.first;

    showModalEmpty(
      context,
      isDismissible: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          container(
            radius: BorderRadius.circular(10),
            padding: const EdgeInsets.all(10),
            backgroundColor: Colors.grey.shade800,
            child: text("Escolha a concessionaria que você trabalha, utilizamos essa informação para a melhor experiencia dos usuarios no aplicativo.", bold: true, fontSize: 15, color: Colors.white, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<ConcessionariaModel>(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent, width: 0.5), borderRadius: BorderRadius.circular(40)),
              enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent, width: 0.5), borderRadius: BorderRadius.circular(40)),
              disabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(40)),
              focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent, width: 0.5), borderRadius: BorderRadius.circular(40)),
              hintText: "Escolha uma opção",
              hintStyle: const TextStyle(fontFamily: 'lato', fontSize: 13, color: Colors.grey),
            ),
            value: dropdownValue,
            onChanged: (ConcessionariaModel? value) => setState(() => dropdownValue = value!),
            items: list,
          ),
          const SizedBox(height: 20),
          elevatedButtonText(
            "SALVAR",
            function: () => _saveConcessionaria(dropdownValue),
            width: MediaQuery.of(context).size.width,
            color: AppColor.primaryColor,
            textColor: Colors.white,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
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
        titleSize: 25,
        valueSize: 13,
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
              avatar("https://st3.depositphotos.com/9998432/13335/v/450/depositphotos_133352156-stock-illustration-default-placeholder-profile-icon.jpg"),
              const SizedBox(width: 20),
              infoColumn(
                title: homeState.usuarioModel.nomeUsuario ?? "",
                value: homeState.usuarioModel.nomeConcessionaria ?? "",
                width: MediaQuery.of(context).size.width / 3,
                titleSize: 17,
                spacing: true,
                ovewflowValue: false,
              ),
            ],
          ),
          infoColumn(
            title: homeState.usuarioModel.pontosUsuario.toString(),
            value: "Pontos",
            titleSize: 25,
            valueSize: 13,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<ConcessionariaModel> _menuItem(ConcessionariaModel concessionariaModel) {
    return DropdownMenuItem<ConcessionariaModel>(
      value: concessionariaModel,
      child: Row(
        children: [
          text(concessionariaModel.nomeConcessionaria ?? "aaa 3"),
          text(" (${concessionariaModel.marcaConcessionaria})", bold: true),
        ],
      ),
    );
  }

  void _onChangeState(InicioState state) async {
    UsuarioModel usuarioModel = await getModelLocal();
    if (usuarioModel.nomeConcessionaria == null || usuarioModel.nomeConcessionaria == "" && !salvouConcessionaria) {
      _showModalConcessionaria(state);
    }
  }

  Widget _body(InicioState homeState) {
    List<Widget> cardsPromocao = [];
    cardsPromocao.add(const SizedBox(width: 10));

    for (VaucherModel model in homeState.vaucherListPromocao) {
      cardsPromocao.add(cardVaucher(model));
    }

    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: AppColor.primaryColor,
      strokeWidth: 2,
      onRefresh: _loadHome,
      child: ListView(
        children: [
          _header(homeState),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _cardInfo(value: homeState.usuarioModel.pontosPedentesUsuario.toString(), title: "Pontos pendentes"),
              _cardInfo(value: "R\$${homeState.usuarioModel.valorPix},00", title: "Em pix"),
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
            return erro(state.errorModel, function: () => _loadHome());
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
