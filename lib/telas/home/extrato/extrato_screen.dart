import 'package:app_cashback_soamer/app_widget/app_consts/app_animations.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart' as cashboost;
import 'package:app_cashback_soamer/telas/home/extrato/extrato_bloc.dart';
import 'package:app_cashback_soamer/telas/home/extrato/extrato_event.dart';
import 'package:app_cashback_soamer/telas/home/extrato/extrato_state.dart';
import 'package:app_cashback_soamer/models/extrato_model.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muller_package/muller_package.dart';

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


    void adicionaValores(ExtratoModel model) {
      if(formataStringParaDateTime(model.data!).day == DateTime.now().day) {
        if (model.entrada!) {
          totalEntrada += model.pontos!;
        } else {
          totalSaida += model.pontos!;
        }
      }
    }

    List<Widget> registros = [];

    for (ExtratoModel model in extratoModel) {
      adicionaValores(model);
      registros.add(_cardExtrato(model));
    }

    if (registros.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appAnimation(AppAnimations.notFound, height: 300, repete: false),
            appText(
              AppStrings.nenhumRegistroEncontrado,
              textAlign: TextAlign.center,
              fontSize: AppFontSizes.normal,
            ),
            appSizedBox(height: 100),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(AppSpacing.normal),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          appSizedBox(height: AppSpacing.normal),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _cardEntradaSaida(title: AppStrings.totalSaidasHoje, value: "-$totalSaida", entrada: false),
              _cardEntradaSaida(title: AppStrings.totalEntradasHoje, value: "+$totalEntrada", entrada: true),
            ],
          ),
          appSizedBox(height:AppSpacing.normal),
          ...registros.reversed,
        ],
      ),
    );
  }

  Widget _bodyBuilder() {
    return RefreshIndicator(
      color: AppColors.white,
      strokeWidth: 2,
      backgroundColor: cashboost.AppColors.primaryColor,
      onRefresh: _loadExtrato,
      child: BlocBuilder<ExtratoBloc, ExtratoState>(
        bloc: bloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case ExtratoLoadingState:
              return appLoadingAnimation(animation: AppAnimations.loading);
            case ExtratoSuccessState:
              return _body(state.extratoModel);
            case ExtratoErrorState:
              return appError(state.errorModel, function: () => _loadExtrato());
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
      appBarColor: cashboost.AppColors.primaryColor,
      title: AppStrings.extrato,
      hideBackIcon: true,
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
