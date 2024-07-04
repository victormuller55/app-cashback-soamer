import 'package:app_cashback_soamer/models/concessionaria_model.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';

abstract class InicioState {
  VendedorModel usuarioModel;
  List<VaucherModel> vaucherListPromocao;
  List<VaucherModel> vaucherListMaisTrocados;
  List<ConcessionariaModel> concessionariaList;
  ErrorModel errorModel;

  InicioState({
    required this.usuarioModel,
    required this.vaucherListPromocao,
    required this.vaucherListMaisTrocados,
    required this.concessionariaList,
    required this.errorModel,
  });
}

class InicioInitialState extends InicioState {
  InicioInitialState()
      : super(
          usuarioModel: VendedorModel.empty(),
          errorModel: ErrorModel.empty(),
          vaucherListPromocao: [],
          vaucherListMaisTrocados: [],
          concessionariaList: [],
        );
}

class InicioLoadingState extends InicioState {
  InicioLoadingState()
      : super(
          usuarioModel: VendedorModel.empty(),
          errorModel: ErrorModel.empty(),
          vaucherListPromocao: [],
          vaucherListMaisTrocados: [],
          concessionariaList: [],
        );
}

class InicioSuccessState extends InicioState {
  InicioSuccessState({
    required VendedorModel usuarioModel,
    required List<VaucherModel> vaucherListPromocao,
    required List<VaucherModel> vaucherListMaisTrocados,
    required List<ConcessionariaModel> concessionariaList,
  }) : super(
          usuarioModel: usuarioModel,
          vaucherListPromocao: vaucherListPromocao,
          vaucherListMaisTrocados: vaucherListMaisTrocados,
          concessionariaList: concessionariaList,
          errorModel: ErrorModel.empty(),
        );
}

class InicioErrorState extends InicioState {
  InicioErrorState({required ErrorModel errorModel})
      : super(
          usuarioModel: VendedorModel.empty(),
          errorModel: errorModel,
          vaucherListPromocao: [],
          vaucherListMaisTrocados: [],
          concessionariaList: [],
        );
}
