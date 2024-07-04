import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';

abstract class EntrarState {
  ErrorModel errorModel;
  VendedorModel usuarioModel;

  EntrarState({required this.usuarioModel, required this.errorModel});
}

class EntrarInitialState extends EntrarState {
  EntrarInitialState() : super(usuarioModel: VendedorModel.empty(), errorModel: ErrorModel.empty());
}

class EntrarLoadingState extends EntrarState {
  EntrarLoadingState() : super(usuarioModel: VendedorModel.empty(), errorModel: ErrorModel.empty());
}

class EntrarSuccessState extends EntrarState {
  EntrarSuccessState({required VendedorModel usuarioModel}) : super(usuarioModel: usuarioModel, errorModel: ErrorModel.empty());
}

class EntrarErrorState extends EntrarState {
  EntrarErrorState({required ErrorModel errorModel}) : super(usuarioModel: VendedorModel.empty(), errorModel: errorModel);
}
