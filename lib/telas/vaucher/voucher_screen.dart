import 'package:app_cashback_soamer/app_widget/app_consts/app_animations.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_colors.dart' as cashboost;
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';
import 'package:app_cashback_soamer/telas/vaucher/voucher_bloc.dart';
import 'package:app_cashback_soamer/telas/vaucher/voucher_event.dart';
import 'package:app_cashback_soamer/telas/vaucher/voucher_state.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muller_package/muller_package.dart';

class VaucherScreen extends StatefulWidget {
  final VaucherModel model;
  final String hero;
  final int pontos;

  const VaucherScreen({
    super.key,
    required this.model,
    required this.hero,
    required this.pontos,
  });

  @override
  State<VaucherScreen> createState() => _VaucherScreenState();
}

class _VaucherScreenState extends State<VaucherScreen> {

  VoucherBloc bloc = VoucherBloc();

  Widget _bodySuccess(VoucherState voucherState) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.normal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            avatar(AppEndpoints.endpointImageVoucher(widget.model.id!), radius: 100),
            appSizedBox(height:AppSpacing.medium),
            appText(
              AppStrings.voucherAdquiridoComSucesso,
              bold: true,
              color: cashboost.AppColors.primaryColor,
              fontSize: AppFontSizes.normal,
              textAlign: TextAlign.center,
            ),
            appSizedBox(height:AppSpacing.normal),
            appContainer(
              radius: BorderRadius.circular(AppRadius.medium),
              padding: EdgeInsets.all(AppSpacing.normal),
              backgroundColor: cashboost.AppColors.grey300,
              child: appText(
                AppStrings.voucherComprado,
                color: cashboost.AppColors.grey600,
                fontSize: AppFontSizes.normal,
                textAlign: TextAlign.center,
              ),
            ),
            appSizedBox(height:AppSpacing.medium),
            appElevatedButtonText(
              AppStrings.concluir,
              function: () => Navigator.pop(context),
              color:  cashboost.AppColors.primaryColor,
              textColor:  cashboost.AppColors.white,
              width: MediaQuery.of(context).size.width,
            ),
            appSizedBox(height:AppSpacing.big),
          ],
        ),
      ),
    );
  }

  void _showModal() {
    showModalEmpty(
      context,
      height: 350,
      child: Column(
        children: [
          appSizedBox(height:AppSpacing.medium),
          appText(widget.model.titulo!, fontSize: AppFontSizes.medium, bold: true),
          appSizedBox(height:AppSpacing.normal),
          appContainer(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(AppSpacing.normal),
            backgroundColor:  cashboost.AppColors.grey300,
            radius: BorderRadius.circular(AppRadius.normal),
            child: Center(
              child: appText(
                "Você realmente deseja trocar ${widget.model.pontos} pontos deste vaucher?",
                fontSize: AppFontSizes.normal,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          appSizedBox(height:AppSpacing.medium),
          appElevatedButtonText(
            AppStrings.trocar.toUpperCase(),
            width: MediaQuery.of(context).size.width,
            color:  cashboost.AppColors.green,
            textColor:  cashboost.AppColors.white,
            function: () {
              if (widget.model.pontos! <= widget.pontos) {
                bloc.add(VoucherTrocarEvent(widget.model.id!));
                Navigator.pop(context);
              } else {
                showSnackbarWarning(message: AppStrings.pontosInsuficientes);
                Navigator.pop(context);
              }
            },
          ),
          appSizedBox(height:AppSpacing.normal),
          appElevatedButtonText(
            AppStrings.cancelar,
            width: MediaQuery.of(context).size.width,
            function: () => Navigator.pop(context),
          ),
          appSizedBox(height:AppSpacing.medium),
        ],
      ),
    );
  }

  Widget _buttonTrocar() {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.normal),
      child: appElevatedButtonText(
        AppStrings.trocarVoucher,
        function: () => _showModal(),
        color:  cashboost.AppColors.primaryColor,
        textColor:  cashboost.AppColors.white,
      ),
    );
  }

  Widget _body() {
    return ListView(
      children: [
        Hero(
          tag: widget.hero,
          child: appContainer(
            height: 200,
            width: MediaQuery.of(context).size.width,
            backgroundColor:  cashboost.AppColors.grey300,
            image: NetworkImage(AppEndpoints.endpointImageVoucher(widget.model.id!)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.medium,
            right: AppSpacing.medium,
            top: AppSpacing.medium,
            bottom: AppSpacing.small,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  infoColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    title: widget.model.titulo ?? "",
                    value: "Até ${widget.model.dataFinal}",
                    titleColor:  cashboost.AppColors.black,
                    valueColor:  cashboost.AppColors.grey600,
                    titleSize: 18,
                    valueSize: 15,
                    spacing: true,
                  ),
                  infoColumn(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    title: widget.model.desconto == 0 ? AppStrings.vazio : "${widget.model.pontosCheio} Pontos",
                    value: widget.model.desconto == 0 ? "${widget.model.pontosCheio} Pontos" : "${widget.model.pontos} Pontos",
                    titleColor:  cashboost.AppColors.red,
                    valueColor:  cashboost.AppColors.black,
                    titleSize: 14,
                    valueSize: 18,
                    cortarTitle: true,
                  ),
                ],
              ),
              appSizedBox(height:AppSpacing.medium),
              appContainer(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(AppSpacing.normal),
                backgroundColor:  cashboost.AppColors.grey300,
                radius: BorderRadius.circular(AppRadius.medium),
                child: Center(child: appText(widget.model.info!, fontSize: AppFontSizes.normal, textAlign: TextAlign.justify)),
              ),
            ],
          ),
        ),
        appSizedBox(height:AppSpacing.medium),
        ExpansionTile(
          collapsedBackgroundColor:  cashboost.AppColors.white,
          textColor:  cashboost.AppColors.black,
          title: appText(AppStrings.perguntaVoucher1),
          children: [
            appContainer(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(AppSpacing.normal),
              backgroundColor:  cashboost.AppColors.grey300,
              child: Center(
                child: appText(
                  AppStrings.explicacaoComoUtilizarVoucher,
                  fontSize: AppFontSizes.normal,
                  color:  cashboost.AppColors.grey600,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
        ExpansionTile(
          collapsedBackgroundColor:  cashboost.AppColors.white,
          textColor:  cashboost.AppColors.black,
          title: appText(AppStrings.perguntaVoucher2),
          children: [
            appContainer(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(AppSpacing.normal),
              backgroundColor:  cashboost.AppColors.grey300,
              child: Center(
                child: appText(
                  AppStrings.explicacaoTempoVoucher,
                  fontSize: AppFontSizes.normal,
                  textAlign: TextAlign.justify,
                  color:  cashboost.AppColors.grey600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _bodyBuilder() {
    return BlocBuilder<VoucherBloc, VoucherState>(
      bloc: bloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case VoucherLoadingState:
            return appLoadingAnimation(animation: AppAnimations.loading);
          case VoucherErrorState:
            return appError(state.errorModel, function: () => {});
          case VoucherSuccessState:
            return _bodySuccess(state);
          default:
            return _body();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      body: _bodyBuilder(),
      appBarBackground: cashboost.AppColors.primaryColor,
      title: widget.model.titulo ?? "",
      fixedBottom: bloc.state.runtimeType == VoucherSuccessState ? null : _buttonTrocar(),
      actions: [
        infoColumn(
          title: widget.pontos.toString(),
          value: AppStrings.pontos,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ],
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
