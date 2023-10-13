import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';

abstract class VaucherState {
  ErrorModel errorModel;
  List<VaucherModel> vaucherModelList;
  List<VaucherModel> vaucherModelListPromocao;
  List<VaucherModel> vaucherModelListMaisTrocados;

  VaucherState({required this.vaucherModelList, required this.errorModel, required this.vaucherModelListPromocao, required this.vaucherModelListMaisTrocados});
}

class VaucherInitialState extends VaucherState {
  VaucherInitialState() : super(vaucherModelList: [], errorModel: ErrorModel.empty(), vaucherModelListPromocao: [], vaucherModelListMaisTrocados: []);
}

class VaucherLoadingState extends VaucherState {
  VaucherLoadingState() : super(vaucherModelList: [], errorModel: ErrorModel.empty(), vaucherModelListPromocao: [], vaucherModelListMaisTrocados: []);
}

class VaucherSuccessState extends VaucherState {
  VaucherSuccessState({required List<VaucherModel> vaucherModel, required List<VaucherModel> vaucherModelListMaisTrocados, required List<VaucherModel> vaucherModelListPromocao}) : super(vaucherModelList: vaucherModel, errorModel: ErrorModel.empty(), vaucherModelListMaisTrocados: vaucherModelListMaisTrocados, vaucherModelListPromocao: vaucherModelListPromocao);
}

class VaucherErrorState extends VaucherState {
  VaucherErrorState({required ErrorModel errorModel}) : super(vaucherModelList: [], vaucherModelListPromocao: [], vaucherModelListMaisTrocados: [], errorModel: errorModel);
}
