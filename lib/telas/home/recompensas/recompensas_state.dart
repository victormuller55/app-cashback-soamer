import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';

abstract class VaucherState {
  ErrorModel errorModel;
  List<VaucherModel> vaucherModelList;

  VaucherState({required this.vaucherModelList, required this.errorModel});
}

class VaucherInitialState extends VaucherState {
  VaucherInitialState({required List<VaucherModel> contaModel, required ErrorModel errorModel}) : super(vaucherModelList: contaModel, errorModel: errorModel);
}

class VaucherLoadingState extends VaucherState {
  VaucherLoadingState({required List<VaucherModel> vaucherModel, required ErrorModel errorModel}) : super(vaucherModelList: vaucherModel, errorModel: errorModel);
}

class VaucherSuccessState extends VaucherState {
  VaucherSuccessState({required List<VaucherModel> vaucherModel, required ErrorModel errorModel}) : super(vaucherModelList: vaucherModel, errorModel: errorModel);
}

class VaucherErrorState extends VaucherState {
  VaucherErrorState({required List<VaucherModel> vaucherModel, required ErrorModel errorModel}) : super(vaucherModelList: vaucherModel, errorModel: errorModel);
}
