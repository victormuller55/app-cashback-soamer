import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/home_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';

abstract class VaucherState {
  ErrorModel errorModel;
  HomeModel dadosUsuarioModel;
  List<VaucherModel> vaucherModelList;
  List<VaucherModel> vaucherModelListPromocao;
  List<VaucherModel> vaucherModelListMaisTrocados;

  VaucherState({required this.vaucherModelList, required this.errorModel, required this.vaucherModelListPromocao, required this.vaucherModelListMaisTrocados, required this.dadosUsuarioModel});
}

class VaucherInitialState extends VaucherState {
  VaucherInitialState() : super(vaucherModelList: [], errorModel: ErrorModel.empty(), vaucherModelListPromocao: [], vaucherModelListMaisTrocados: [], dadosUsuarioModel: HomeModel.empty());
}

class VaucherLoadingState extends VaucherState {
  VaucherLoadingState() : super(vaucherModelList: [], errorModel: ErrorModel.empty(), vaucherModelListPromocao: [], vaucherModelListMaisTrocados: [], dadosUsuarioModel: HomeModel.empty());
}

class VaucherSuccessState extends VaucherState {
  VaucherSuccessState({
    required HomeModel dadosUsuarioModel,
    required List<VaucherModel> vaucherModel,
    required List<VaucherModel> vaucherModelListMaisTrocados,
    required List<VaucherModel> vaucherModelListPromocao,
  }) : super(
          dadosUsuarioModel: dadosUsuarioModel,
          vaucherModelList: vaucherModel,
          vaucherModelListMaisTrocados: vaucherModelListMaisTrocados,
          vaucherModelListPromocao: vaucherModelListPromocao,
          errorModel: ErrorModel.empty(),
        );
}

class VaucherErrorState extends VaucherState {
  VaucherErrorState({required ErrorModel errorModel}) : super(vaucherModelList: [], vaucherModelListPromocao: [], vaucherModelListMaisTrocados: [], errorModel: errorModel, dadosUsuarioModel: HomeModel.empty());
}
