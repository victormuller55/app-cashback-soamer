import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_font_sizes.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_radius.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_spacing.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_strings.dart';
import 'package:app_cashback_soamer/functions/formatters.dart';
import 'package:app_cashback_soamer/models/extrato_model.dart';
import 'package:app_cashback_soamer/telas/home/extrato/extrato_bloc.dart';
import 'package:app_cashback_soamer/telas/home/extrato/extrato_event.dart';
import 'package:app_cashback_soamer/telas/home/extrato/extrato_state.dart';
import 'package:app_cashback_soamer/widgets/container.dart';
import 'package:app_cashback_soamer/widgets/erro.dart';
import 'package:app_cashback_soamer/widgets/loading.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:app_cashback_soamer/widgets/sized_box.dart';
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
    return appContainer(
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
    Widget trailing = appText("");

    if (extratoModel.entrada ?? false) {
      if (extratoModel.titulo!.contains("Venda Aprovada")) {
        trailing = appText("+${extratoModel.pontos ?? 0} Pts", fontSize: AppFontSizes.normal, bold: true, color: AppColors.green);
      }
    }

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.small),
      child: appContainer(
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
                child: appText(extratoModel.titulo ?? "", fontSize: AppFontSizes.small, bold: true),
              ),
              subtitle: appText(extratoModel.descricao ?? "", fontSize: AppFontSizes.small),
              trailing: trailing,
              leading: appContainer(
                width: 40,
                height: 40,
                child: Center(
                  child: appText(formatarDataApi(extratoModel.data.toString())),
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

    DateTime dataAtual = DateTime.now();
    DateTime dataOntem = dataAtual.subtract(const Duration(days: 1));
    DateTime dataAnterior = dataAtual.subtract(const Duration(days: 2));

    List<Widget> hoje = [];
    List<Widget> ontem = [];
    List<Widget> anterior = [];

    void addCardToList(DateTime dataRegistro, ExtratoModel extratoModel) {
      if (dataRegistro.isBefore(dataOntem)) {
        ontem.add(_cardExtrato(extratoModel));
      } else if (dataRegistro.isBefore(dataAnterior)) {
        anterior.add(_cardExtrato(extratoModel));
      } else {
        if (extratoModel.entrada!) {
          totalEntrada += extratoModel.pontos!;
        } else {
          totalSaida += extratoModel.pontos!;
        }
        hoje.add(_cardExtrato(extratoModel));
      }
    }

    for (ExtratoModel model in extratoModel) {
      DateTime dataRegistro = DateTime.parse(model.data!).subtract(const Duration(hours: 3));
      addCardToList(dataRegistro, model);
    }

    if (hoje.isEmpty && ontem.isEmpty && anterior.isEmpty) {
      return Center(child: appText(AppStrings.nenhumRegistroEncontrado, textAlign: TextAlign.center, fontSize: AppFontSizes.normal));
    }

    Widget buildSection(String title, List<Widget> items) {
      if (items.isNotEmpty) {
        return Column(
          children: [
            Center(child: appText(title.toUpperCase(), bold: true, color: AppColors.primaryColor)),
            appSizedBoxHeight(AppSpacing.normal),
            ...items.reversed,
          ],
        );
      }

      return appContainer();
    }

    return Padding(
      padding: EdgeInsets.all(AppSpacing.normal),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          appSizedBoxHeight(AppSpacing.normal),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _cardEntradaSaida(title: AppStrings.totalSaidasHoje, value: "-$totalSaida", entrada: false),
              _cardEntradaSaida(title: AppStrings.totalEntradasHoje, value: "+$totalEntrada", entrada: true),
            ],
          ),
          appSizedBoxHeight(AppSpacing.normal),
          buildSection(AppStrings.hoje, hoje),
          appSizedBoxHeight(AppSpacing.small),
          buildSection(AppStrings.ontem, ontem),
          appSizedBoxHeight(AppSpacing.small),
          buildSection(AppStrings.anterior, anterior),
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
              return appContainer();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      body: _bodyBuilder(),
      title: AppStrings.extrato,
      hideBackArrow: true,
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
