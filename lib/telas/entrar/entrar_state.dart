import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';

abstract class EntrarState {
  ErrorModel errorModel;
  UsuarioModel usuarioModel;

  EntrarState({required this.usuarioModel, required this.errorModel});
}

class EntrarInitialState extends EntrarState {
  EntrarInitialState() : super(usuarioModel: UsuarioModel.empty(), errorModel: ErrorModel.empty());
}

class EntrarLoadingState extends EntrarState {
  EntrarLoadingState() : super(usuarioModel: UsuarioModel.empty(), errorModel: ErrorModel.empty());
}

class EntrarSuccessState extends EntrarState {
  EntrarSuccessState({required UsuarioModel usuarioModel}) : super(usuarioModel: usuarioModel, errorModel: ErrorModel.empty());
}

class EntrarErrorState extends EntrarState {
  EntrarErrorState({required ErrorModel errorModel}) : super(usuarioModel: UsuarioModel.empty(), errorModel: errorModel);
}
