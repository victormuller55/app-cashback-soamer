import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';

abstract class AlterarSenhaState {
  ErrorModel errorModel;
  UsuarioModel usuarioModel;

  AlterarSenhaState({required this.usuarioModel, required this.errorModel});
}

class AlterarSenhaInitialState extends AlterarSenhaState {
  AlterarSenhaInitialState() : super(usuarioModel: UsuarioModel.empty(), errorModel: ErrorModel.empty());
}

class AlterarSenhaLoadingState extends AlterarSenhaState {
  AlterarSenhaLoadingState() : super(usuarioModel: UsuarioModel.empty(), errorModel: ErrorModel.empty());
}

class AlterarSenhaSuccessState extends AlterarSenhaState {
  AlterarSenhaSuccessState({required UsuarioModel usuarioModel}) : super(usuarioModel: usuarioModel, errorModel: ErrorModel.empty());
}

class AlterarSenhaErrorState extends AlterarSenhaState {
  AlterarSenhaErrorState({required ErrorModel errorModel}) : super(usuarioModel: UsuarioModel.empty(), errorModel: errorModel);
}
