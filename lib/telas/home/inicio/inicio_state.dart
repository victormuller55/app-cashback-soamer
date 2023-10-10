import 'package:app_cashback_soamer/models/concessionaria_model.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';

abstract class InicioState {
  UsuarioModel usuarioModel;
  List<VaucherModel> vaucherListPromocao;
  List<ConcessionariaModel> concessionariaList;
  ErrorModel errorModel;

  InicioState({
    required this.usuarioModel,
    required this.vaucherListPromocao,
    required this.concessionariaList,
    required this.errorModel,
  });
}

class InicioInitialState extends InicioState {
  InicioInitialState() : super(usuarioModel: UsuarioModel.empty(), errorModel: ErrorModel.empty(), vaucherListPromocao: [], concessionariaList: []);
}

class InicioLoadingState extends InicioState {
  InicioLoadingState() : super(usuarioModel: UsuarioModel.empty(), errorModel: ErrorModel.empty(), vaucherListPromocao: [], concessionariaList: []);
}

class InicioSuccessState extends InicioState {
  InicioSuccessState({required UsuarioModel usuarioModel, required List<VaucherModel> vaucherListPromocao, required List<ConcessionariaModel> concessionariaList}) : super(usuarioModel: usuarioModel, errorModel: ErrorModel.empty(), vaucherListPromocao: vaucherListPromocao, concessionariaList: concessionariaList);
}

class InicioErrorState extends InicioState {
  InicioErrorState({required ErrorModel errorModel}) : super(usuarioModel: UsuarioModel.empty(), errorModel: errorModel, vaucherListPromocao: [], concessionariaList: []);
}
