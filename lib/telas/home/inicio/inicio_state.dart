import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/home_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';

abstract class InicioState {
  ErrorModel errorModel;
  List<VaucherModel> vaucherList;
  HomeModel homeModel;

  InicioState({
    required this.homeModel,
    required this.errorModel,
    required this.vaucherList,
  });
}

class InicioInitialState extends InicioState {
  InicioInitialState() : super(homeModel: HomeModel.empty(), errorModel: ErrorModel.empty(), vaucherList: []);
}

class InicioLoadingState extends InicioState {
  InicioLoadingState() : super(homeModel: HomeModel.empty(), errorModel: ErrorModel.empty(), vaucherList: []);
}

class InicioSuccessState extends InicioState {
  InicioSuccessState({required HomeModel homeModel, required List<VaucherModel> vaucherList}) : super(homeModel: homeModel, errorModel: ErrorModel.empty(), vaucherList: vaucherList);
}

class InicioErrorState extends InicioState {
  InicioErrorState({required ErrorModel errorModel}) : super(homeModel: HomeModel.empty(), errorModel: errorModel, vaucherList: []);
}
