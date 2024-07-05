import 'package:app_cashback_soamer/models/home_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';
import 'package:muller_package/muller_package.dart';

abstract class VaucherState {
  ErrorModel errorModel;
  HomeModel dadosVendedorModel;
  List<VaucherModel> vouchersLista;
  List<VaucherModel> promocaoLista;
  List<VaucherModel> maisTrocadosLista;

  VaucherState({required this.vouchersLista, required this.errorModel, required this.promocaoLista, required this.maisTrocadosLista, required this.dadosVendedorModel});
}

class VaucherInitialState extends VaucherState {
  VaucherInitialState() : super(vouchersLista: [], errorModel: ErrorModel.empty(), promocaoLista: [], maisTrocadosLista: [], dadosVendedorModel: HomeModel.empty());
}

class VaucherLoadingState extends VaucherState {
  VaucherLoadingState() : super(vouchersLista: [], errorModel: ErrorModel.empty(), promocaoLista: [], maisTrocadosLista: [], dadosVendedorModel: HomeModel.empty());
}

class VaucherSuccessState extends VaucherState {
  VaucherSuccessState({
    required HomeModel dadosVendedorModel,
    required List<VaucherModel> vaucherModel,
    required List<VaucherModel> vaucherModelListMaisTrocados,
    required List<VaucherModel> vaucherModelListPromocao,
  }) : super(
          dadosVendedorModel: dadosVendedorModel,
          vouchersLista: vaucherModel,
          maisTrocadosLista: vaucherModelListMaisTrocados,
          promocaoLista: vaucherModelListPromocao,
          errorModel: ErrorModel.empty(),
        );
}

class VaucherErrorState extends VaucherState {
  VaucherErrorState({required ErrorModel errorModel}) : super(vouchersLista: [], promocaoLista: [], maisTrocadosLista: [], errorModel: errorModel, dadosVendedorModel: HomeModel.empty());
}
