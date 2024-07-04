import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/concessionaria_model.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
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
    bloc.add(SetConcessionariaEvent(value.id!));
    addLocalDataString("nome_concessionaria", value.nome!);
    salvouConcessionaria = true;
    Navigator.pop(context);
    _loadHome();
  }

  Future<void> _loadHome() async {
    VendedorModel vendedorModel = await getModelLocal();
    bloc.add(InicioLoadEvent(vendedorModel.email!));
  }

  void _loadConcessionaria() async {
    VendedorModel vendedorModel = await getModelLocal();
    if (vendedorModel.nomeConcessionaria == null || vendedorModel.nomeConcessionaria == "") {
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
          appContainer(
            radius: BorderRadius.circular(10),
            padding: const EdgeInsets.all(10),
            backgroundColor: Colors.grey.shade800,
            child: appText("Escolha a concessionaria que você trabalha, utilizamos essa informação para a melhor experiencia dos usuarios no aplicativo.", bold: true, fontSize: 15, color: Colors.white, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 20),
          list.isNotEmpty
              ? DropdownButtonFormField<ConcessionariaModel>(
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
                )
              : appText("Não foi encontrado nenhuma concessionaria"),
          const SizedBox(height: 20),
          appElevatedButtonText(
            "SALVAR",
            function: () => _saveConcessionaria(dropdownValue),
            width: MediaQuery.of(context).size.width,
            color: AppColors.primaryColor,
            textColor: Colors.white,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _cardInfo({required String title, required String value}) {
    return appContainer(
      radius: BorderRadius.circular(20),
      backgroundColor: Colors.grey.shade300,
      width: MediaQuery.of(context).size.width / 2.2,
      height: 100,
      child: infoColumn(
        title: value,
        value: title,
        titleSize: 25,
        valueSize: 13,
        titleColor: AppColors.primaryColor,
        valueColor: Colors.grey.shade600,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  Widget _header(InicioState homeState) {
    return appContainer(
      height: MediaQuery.of(context).size.height / 6,
      backgroundColor: AppColors.primaryColor,
      radius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              avatar(AppEndpoints.endpointImageVendedor(homeState.vendedorModel.id!)),
              const SizedBox(width: 20),
              infoColumn(
                title: homeState.vendedorModel.nome ?? "",
                value: homeState.vendedorModel.nomeConcessionaria ?? "",
                width: MediaQuery.of(context).size.width / 3,
                titleSize: 17,
                spacing: true,
                ovewflowValue: false,
              ),
            ],
          ),
          infoColumn(
            title: homeState.vendedorModel.pontos.toString(),
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
          appText(concessionariaModel.nome ?? ""),
          appText(" (${concessionariaModel.marca})"),
          SizedBox(width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width / 1.5), child: appText(" - ${concessionariaModel.endereco}", color: Colors.grey, overflow: true)),
        ],
      ),
    );
  }

  Widget componenteVoucher({required String title, required List<Widget> lista}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: appText(title, bold: true, color: Colors.grey, fontSize: 14),
        ),
        SizedBox(
          height: lista.isNotEmpty ? 180 : 100,
          child: lista.isNotEmpty ? Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: lista,
            ),
          ): Center(child: appText("Nenhum Voucher Encontrado", color: Colors.grey))
        ),
      ],
    );
  }

  void _onChangeState(InicioState state) async {

    VendedorModel vendedorModel = await getModelLocal();

    if (vendedorModel.nomeConcessionaria == null || vendedorModel.nomeConcessionaria == "") {
      if (state.concessionariaList.isNotEmpty) {
        if (!salvouConcessionaria) {
          _showModalConcessionaria(state);
        }
      }
    }
  }

  Widget _body(InicioState homeState) {
    List<Widget> cardsPromocao = [];
    List<Widget> cardsMaisTrocados = [];

    for (int i = 0; i <= homeState.vaucherListPromocao.length - 1; i++) {
      cardsPromocao.add(cardVaucher(homeState.vaucherListPromocao[i], "hero$i", homeState.vendedorModel.pontos!));
    }

    for (int i = 0; i <= homeState.vaucherListMaisTrocados.length - 1; i++) {
      cardsMaisTrocados.add(cardVaucher(homeState.vaucherListMaisTrocados[i], "Mhero$i", homeState.vendedorModel.pontos!));
    }

    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: AppColors.primaryColor,
      strokeWidth: 2,
      onRefresh: _loadHome,
      child: ListView(
        children: [
          _header(homeState),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _cardInfo(value: homeState.vendedorModel.pontosPendentes.toString(), title: "Pontos pendentes"),
              _cardInfo(value: "R\$${homeState.vendedorModel.valorPix},00", title: "Em pix"),
            ],
          ),
          const SizedBox(height: 15),
          componenteVoucher(title: "PROMOÇÃO", lista: cardsPromocao),
          componenteVoucher(title: "OS MAIS TROCADOS", lista: cardsMaisTrocados),
          const SizedBox(height: 50),
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
            return appContainer();
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
