import 'package:app_cashback_soamer/models/concessionaria_model.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';

abstract class EditarUsuarioState {
  VendedorModel usuarioModel;
  ErrorModel errorModel;

  EditarUsuarioState({required this.usuarioModel, required this.errorModel});
}

class EditarUsuarioInitialState extends EditarUsuarioState {
  EditarUsuarioInitialState() : super(usuarioModel: VendedorModel.empty(), errorModel: ErrorModel.empty());
}

class EditarUsuarioLoadingState extends EditarUsuarioState {
  EditarUsuarioLoadingState() : super(usuarioModel: VendedorModel.empty(), errorModel: ErrorModel.empty());
}

class EditarUsuarioSuccessState extends EditarUsuarioState {
  EditarUsuarioSuccessState({required VendedorModel usuarioModel, required List<ConcessionariaModel> concessionariaModelList}) : super(usuarioModel: usuarioModel, errorModel: ErrorModel.empty());
}

class EditarUsuarioErrorState extends EditarUsuarioState {
  EditarUsuarioErrorState({required ErrorModel errorModel}) : super(usuarioModel: VendedorModel.empty(), errorModel: errorModel);
}
