import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';

abstract class CadastroState {
  ErrorModel errorModel;
  UsuarioModel contaModel;

  CadastroState({required this.contaModel, required this.errorModel});
}

class CadastroInitialState extends CadastroState {
  CadastroInitialState({required UsuarioModel contaModel, required ErrorModel errorModel}) : super(contaModel: contaModel, errorModel: errorModel);
}

class CadastroLoadingState extends CadastroState {
  CadastroLoadingState({required UsuarioModel contaModel, required ErrorModel errorModel}) : super(contaModel: contaModel, errorModel: errorModel);
}

class CadastroSuccessState extends CadastroState {
  CadastroSuccessState({required UsuarioModel usuarioModel, required ErrorModel errorModel}) : super(contaModel: usuarioModel, errorModel: errorModel);
}

class CadastroErrorState extends CadastroState {
  CadastroErrorState({required UsuarioModel contaModel, required ErrorModel errorModel}) : super(contaModel: contaModel, errorModel: errorModel);
}
