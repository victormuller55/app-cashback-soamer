import 'package:app_cashback_soamer/app_widget/consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/consts/app_font_sizes.dart';
import 'package:app_cashback_soamer/app_widget/consts/app_radius.dart';
import 'package:app_cashback_soamer/app_widget/consts/app_spacing.dart';
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
  ExtratoBloc bloc = ExtratoBloc();

  Future<void> _loadExtrato() async {
    bloc.add(ExtratoLoadEvent());
  }

  @override
  void initState() {
    _loadExtrato();
    super.initState();
  }

  Widget _cardEntradaSaida({required String title, required String value, bool? entrada}) {
    return container(
      radius: BorderRadius.circular(AppRadius.medium),
      backgroundColor: AppColors.grey300,
      width: MediaQuery.of(context).size.width / 2.2,
      height: 80,
      child: infoColumn(
        title: value,
        value: title,
        titleSize: AppFontSizes.big,
        valueSize: AppFontSizes.small,
        spacing: true,
        titleColor: entrada ?? false ? AppColors.green : AppColors.red,
        valueColor: AppColors.grey,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  Widget _cardExtrato(ExtratoModel extratoModel) {

    Widget trailing = text("");

    if (extratoModel.entrada ?? false) {
      if (extratoModel.titulo!.contains("Venda Aprovada")) {
        trailing = text("+${extratoModel.pontos ?? 0} Pts", fontSize: AppFontSizes.normal, bold: true, color: AppColors.green);
      }
    }

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.small),
      child: container(
        width: MediaQuery.of(context).size.width,
        backgroundColor: AppColors.white,
        radius: BorderRadius.circular(AppRadius.medium),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(AppRadius.normal),
            child: ListTile(
              dense: true,
              title: Padding(
                padding: EdgeInsets.only(bottom: AppRadius.small),
                child: text(extratoModel.titulo ?? "", fontSize: AppFontSizes.small, bold: true),
              ),
              subtitle: text(extratoModel.descricao ?? "", fontSize: AppFontSizes.small),
              trailing: trailing,
              leading: SizedBox(
                width: 40,
                height: 40,
                child: Center(
                  child: text(formatarDataApi(extratoModel.data.toString())),
                ),
              ),
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
        ontem.add(_cardExtrato(model));
      } else if (dataRegistro.isBefore(dataAnterior)) {
        anterior.add(_cardExtrato(model));
      } else {
        if (model.entrada!) {
          totalEntrada = totalEntrada + model.pontos!;
        } else {
          totalSaida = totalSaida + model.pontos!;
        }
        hoje.add(_cardExtrato(model));
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
              _cardEntradaSaida(title: "Total de saídas (Hoje)", value: "-${totalSaida.toString()}", entrada: false),
              _cardEntradaSaida(title: "Total de entradas (Hoje)", value: "+${totalEntrada.toString()}", entrada: true),
            ],
          ),
          const SizedBox(height: 10),
          hoje.isNotEmpty ? Center(child: text("Hoje".toUpperCase(), bold: true, color: AppColors.primaryColor)) : container(),
          const SizedBox(height: 10),
          ...hoje.reversed,
          const SizedBox(height: 5),
          ontem.isNotEmpty ? Center(child: text("Ontem".toUpperCase(), bold: true, color: AppColors.primaryColor)) : container(),
          const SizedBox(height: 10),
          ...ontem.reversed,
          const SizedBox(height: 5),
          anterior.isNotEmpty ? Center(child: text("Anterior".toUpperCase(), bold: true, color: AppColors.primaryColor)) : container(),
          const SizedBox(height: 10),
          ...anterior.reversed,
        ],
      ),
    );
  }

  Widget _bodyBuilder() {
    return RefreshIndicator(
      color: AppColors.white,
      strokeWidth: 2,
      backgroundColor: AppColors.primaryColor,
      onRefresh: _loadExtrato,
      child: BlocBuilder<ExtratoBloc, ExtratoState>(
        bloc: bloc,
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
    return scaffold(
      body: _bodyBuilder(),
      title: "Extrato",
      hideBackArrow: true,
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
