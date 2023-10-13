import 'package:app_cashback_soamer/models/concessionaria_model.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';

abstract class EditarUsuarioState {
  UsuarioModel usuarioModel;
  ErrorModel errorModel;

  EditarUsuarioState({required this.usuarioModel, required this.errorModel});
}

class EditarUsuarioInitialState extends EditarUsuarioState {
  EditarUsuarioInitialState() : super(usuarioModel: UsuarioModel.empty(), errorModel: ErrorModel.empty());
}

class EditarUsuarioLoadingState extends EditarUsuarioState {
  EditarUsuarioLoadingState() : super(usuarioModel: UsuarioModel.empty(), errorModel: ErrorModel.empty());
}

class EditarUsuarioSuccessState extends EditarUsuarioState {
  EditarUsuarioSuccessState({required UsuarioModel usuarioModel, required List<ConcessionariaModel> concessionariaModelList}) : super(usuarioModel: usuarioModel, errorModel: ErrorModel.empty());
}

class EditarUsuarioErrorState extends EditarUsuarioState {
  EditarUsuarioErrorState({required ErrorModel errorModel}) : super(usuarioModel: UsuarioModel.empty(), errorModel: errorModel);
}
