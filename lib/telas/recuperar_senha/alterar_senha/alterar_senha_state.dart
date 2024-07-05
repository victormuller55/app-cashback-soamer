import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:muller_package/muller_package.dart';

abstract class AlterarSenhaState {
  ErrorModel errorModel;
  VendedorModel vendedorModel;

  AlterarSenhaState({required this.vendedorModel, required this.errorModel});
}

class AlterarSenhaInitialState extends AlterarSenhaState {
  AlterarSenhaInitialState() : super(vendedorModel: VendedorModel.empty(), errorModel: ErrorModel.empty());
}

class AlterarSenhaLoadingState extends AlterarSenhaState {
  AlterarSenhaLoadingState() : super(vendedorModel: VendedorModel.empty(), errorModel: ErrorModel.empty());
}

class AlterarSenhaSuccessState extends AlterarSenhaState {
  AlterarSenhaSuccessState({required VendedorModel vendedorModel}) : super(vendedorModel: vendedorModel, errorModel: ErrorModel.empty());
}

class AlterarSenhaErrorState extends AlterarSenhaState {
  AlterarSenhaErrorState({required ErrorModel errorModel}) : super(vendedorModel: VendedorModel.empty(), errorModel: errorModel);
}
