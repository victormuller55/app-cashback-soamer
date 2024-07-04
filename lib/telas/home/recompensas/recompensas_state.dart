import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/home_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';

abstract class VaucherState {
  ErrorModel errorModel;
  HomeModel dadosVendedorModel;
  List<VaucherModel> vaucherModelList;
  List<VaucherModel> vaucherModelListPromocao;
  List<VaucherModel> vaucherModelListMaisTrocados;

  VaucherState({required this.vaucherModelList, required this.errorModel, required this.vaucherModelListPromocao, required this.vaucherModelListMaisTrocados, required this.dadosVendedorModel});
}

class VaucherInitialState extends VaucherState {
  VaucherInitialState() : super(vaucherModelList: [], errorModel: ErrorModel.empty(), vaucherModelListPromocao: [], vaucherModelListMaisTrocados: [], dadosVendedorModel: HomeModel.empty());
}

class VaucherLoadingState extends VaucherState {
  VaucherLoadingState() : super(vaucherModelList: [], errorModel: ErrorModel.empty(), vaucherModelListPromocao: [], vaucherModelListMaisTrocados: [], dadosVendedorModel: HomeModel.empty());
}

class VaucherSuccessState extends VaucherState {
  VaucherSuccessState({
    required HomeModel dadosVendedorModel,
    required List<VaucherModel> vaucherModel,
    required List<VaucherModel> vaucherModelListMaisTrocados,
    required List<VaucherModel> vaucherModelListPromocao,
  }) : super(
          dadosVendedorModel: dadosVendedorModel,
          vaucherModelList: vaucherModel,
          vaucherModelListMaisTrocados: vaucherModelListMaisTrocados,
          vaucherModelListPromocao: vaucherModelListPromocao,
          errorModel: ErrorModel.empty(),
        );
}

class VaucherErrorState extends VaucherState {
  VaucherErrorState({required ErrorModel errorModel}) : super(vaucherModelList: [], vaucherModelListPromocao: [], vaucherModelListMaisTrocados: [], errorModel: errorModel, dadosVendedorModel: HomeModel.empty());
}
