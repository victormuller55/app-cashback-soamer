import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/home_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';

abstract class InicioState {
  HomeModel homeModel;
  List<VaucherModel> vaucherListPromocao;
  List<VaucherModel> vaucherListMaisTrocados;
  ErrorModel errorModel;

  InicioState({
    required this.homeModel,
    required this.vaucherListPromocao,
    required this.vaucherListMaisTrocados,
    required this.errorModel,
  });
}

class InicioInitialState extends InicioState {
  InicioInitialState() : super(homeModel: HomeModel.empty(), errorModel: ErrorModel.empty(), vaucherListPromocao: [], vaucherListMaisTrocados: []);
}

class InicioLoadingState extends InicioState {
  InicioLoadingState() : super(homeModel: HomeModel.empty(), errorModel: ErrorModel.empty(), vaucherListPromocao: [], vaucherListMaisTrocados: []);
}

class InicioSuccessState extends InicioState {
  InicioSuccessState({required HomeModel homeModel, required List<VaucherModel> vaucherListPromocao, required List<VaucherModel> vaucherListMaisTrocados}) : super(homeModel: homeModel, errorModel: ErrorModel.empty(), vaucherListPromocao: vaucherListPromocao, vaucherListMaisTrocados: vaucherListMaisTrocados);
}

class InicioErrorState extends InicioState {
  InicioErrorState({required ErrorModel errorModel}) : super(homeModel: HomeModel.empty(), errorModel: errorModel, vaucherListPromocao: [], vaucherListMaisTrocados: []);
}
