import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';

abstract class CadastroState {
  ErrorModel errorModel;
  UsuarioModel usuarioModel;

  CadastroState({required this.usuarioModel, required this.errorModel});
}

class CadastroInitialState extends CadastroState {
  CadastroInitialState() : super(usuarioModel: UsuarioModel.empty(), errorModel: ErrorModel.empty());
}

class CadastroLoadingState extends CadastroState {
  CadastroLoadingState() : super(usuarioModel: UsuarioModel.empty(), errorModel: ErrorModel.empty());
}

class CadastroSuccessState extends CadastroState {
  CadastroSuccessState({required UsuarioModel usuarioModel}) : super(usuarioModel: usuarioModel, errorModel: ErrorModel.empty());
}

class CadastroErrorState extends CadastroState {
  CadastroErrorState({required ErrorModel errorModel}) : super(usuarioModel: UsuarioModel.empty(), errorModel: errorModel);
}