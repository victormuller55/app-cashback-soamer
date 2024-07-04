import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';

abstract class AlterarSenhaState {
  ErrorModel errorModel;
  VendedorModel usuarioModel;

  AlterarSenhaState({required this.usuarioModel, required this.errorModel});
}

class AlterarSenhaInitialState extends AlterarSenhaState {
  AlterarSenhaInitialState() : super(usuarioModel: VendedorModel.empty(), errorModel: ErrorModel.empty());
}

class AlterarSenhaLoadingState extends AlterarSenhaState {
  AlterarSenhaLoadingState() : super(usuarioModel: VendedorModel.empty(), errorModel: ErrorModel.empty());
}

class AlterarSenhaSuccessState extends AlterarSenhaState {
  AlterarSenhaSuccessState({required VendedorModel usuarioModel}) : super(usuarioModel: usuarioModel, errorModel: ErrorModel.empty());
}

class AlterarSenhaErrorState extends AlterarSenhaState {
  AlterarSenhaErrorState({required ErrorModel errorModel}) : super(usuarioModel: VendedorModel.empty(), errorModel: errorModel);
}
