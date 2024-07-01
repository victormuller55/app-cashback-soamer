import 'package:app_cashback_soamer/app_widget/colors.dart';
import 'package:app_cashback_soamer/functions/formatters.dart';
import 'package:app_cashback_soamer/models/extrato_model.dart';
import 'package:app_cashback_soamer/telas/home/extrato/extrato_bloc.dart';
import 'package:app_cashback_soamer/telas/home/extrato/extrato_event.dart';
import 'package:app_cashback_soamer/telas/home/extrato/extrato_state.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/erro.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExtratoScreen extends StatefulWidget {
  const ExtratoScreen({super.key});

  @override
  State<ExtratoScreen> createState() => _ExtratoScreenState();
}

class _ExtratoScreenState extends State<ExtratoScreen> {
  ExtratoBloc extratoBloc = ExtratoBloc();

  Future<void> _loadExtrato() async {
    extratoBloc.add(ExtratoLoadEvent());
  }

  @override
  void initState() {
    _loadExtrato();
    super.initState();
  }

  Widget _cardInfo({required String title, required String value, bool? entrada}) {
    return container(
      radius: BorderRadius.circular(20),
      backgroundColor: Colors.grey.shade300,
      width: MediaQuery.of(context).size.width / 2.2,
      height: 80,
      child: infoColumn(
        title: value,
        value: title,
        titleSize: 25,
        valueSize: 13,
        spacing: true,
        titleColor: entrada ?? false ? Colors.green : Colors.red,
        valueColor: Colors.grey,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  void _onChangeState(ExtratoState state) {}

  Widget _extrato(ExtratoModel extratoModel) {
    Widget trailing = text("");

    if (extratoModel.entrada ?? false) {
      if (extratoModel.titulo == "Venda aceita") {
        trailing = text("+${extratoModel.pontos ?? 0} Pts", fontSize: 17, bold: true, color: Colors.green);
      }
    } else {
      if (extratoModel.titulo != "Venda recusada") {
        trailing = text("-${extratoModel.pontos ?? 0} Pts", fontSize: 17, bold: true, color: Colors.red);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: container(
        width: MediaQuery.of(context).size.width,
        backgroundColor: Colors.white,
        radius: BorderRadius.circular(20),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              dense: true,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: text(extratoModel.titulo ?? "", fontSize: 15, bold: true),
              ),
              subtitle: text(extratoModel.descricao ?? "", fontSize: 14),
              trailing: trailing,
              leading: SizedBox(width: 40, height: 40, child: Center(child: text(formatarData(extratoModel.data.toString())))),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(List<ExtratoModel> extratoModel) {
    int totalEntrada = 0;
    int totalSaida = 0;

    List<Widget> hoje = [];
    List<Widget> ontem = [];
    List<Widget> anterior = [];

    DateTime dataAtual = DateTime.now();
    DateTime dataOntem = DateTime.now().subtract(Duration(hours: dataAtual.hour - 1));
    DateTime dataAnterior = DateTime.now().subtract(const Duration(days: 2));

    for (ExtratoModel model in extratoModel) {
      DateTime dataRegistro = DateTime.parse(model.data!).subtract(const Duration(hours: 3));

      if (dataRegistro.isBefore(dataOntem)) {
        ontem.add(_extrato(model));
      } else if (dataRegistro.isBefore(dataAnterior)) {
        anterior.add(_extrato(model));
      } else {
        if (model.entrada!) {
          totalEntrada = totalEntrada + model.pontos!;
        } else {
          totalSaida = totalSaida + model.pontos!;
        }
        hoje.add(_extrato(model));
      }
    }

    if (hoje.isEmpty && ontem.isEmpty && anterior.isEmpty) {
      return Center(child: text("Nenhum registro encontrato \n Começe a registrando uma venda!", textAlign: TextAlign.center, fontSize: 15));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _cardInfo(title: "Total de saídas (Hoje)", value: "-${totalSaida.toString()}", entrada: false),
              _cardInfo(title: "Total de entradas (Hoje)", value: "+${totalEntrada.toString()}", entrada: true),
            ],
          ),
          const SizedBox(height: 10),
          hoje.isNotEmpty ? Center(child: text("Hoje".toUpperCase(), bold: true, color: AppColor.primaryColor)) : container(),
          const SizedBox(height: 10),
          ...hoje.reversed,
          const SizedBox(height: 5),
          ontem.isNotEmpty ? Center(child: text("Ontem".toUpperCase(), bold: true, color: AppColor.primaryColor)) : container(),
          const SizedBox(height: 10),
          ...ontem.reversed,
          const SizedBox(height: 5),
          anterior.isNotEmpty ? Center(child: text("Anterior".toUpperCase(), bold: true, color: AppColor.primaryColor)) : container(),
          const SizedBox(height: 10),
          ...anterior.reversed,
        ],
      ),
    );
  }

  Widget _bodyBuilder() {
    return RefreshIndicator(
      color: AppColor.white,
      strokeWidth: 2,
      backgroundColor: AppColor.primaryColor,
      onRefresh: _loadExtrato,
      child: BlocConsumer<ExtratoBloc, ExtratoState>(
        bloc: extratoBloc,
        listener: (context, state) => _onChangeState(state),
        builder: (context, state) {
          switch (state.runtimeType) {
            case ExtratoLoadingState:
              return loading();
            case ExtratoSuccessState:
              return _body(state.extratoModel);
            case ExtratoErrorState:
              return erro(state.errorModel, function: () => _loadExtrato());
            default:
              return container();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(body: _bodyBuilder(), title: "Extrato", hideBackArrow: true);
  }
}
