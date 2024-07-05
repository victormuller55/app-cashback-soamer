
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:muller_package/muller_package.dart';

abstract class CadastroState {
  ErrorModel errorModel;
  VendedorModel vendedorModel;

  CadastroState({required this.vendedorModel, required this.errorModel});
}

class CadastroInitialState extends CadastroState {
  CadastroInitialState() : super(vendedorModel: VendedorModel.empty(), errorModel: ErrorModel.empty());
}

class CadastroLoadingState extends CadastroState {
  CadastroLoadingState() : super(vendedorModel: VendedorModel.empty(), errorModel: ErrorModel.empty());
}

class CadastroSuccessState extends CadastroState {
  CadastroSuccessState({required VendedorModel vendedorModel}) : super(vendedorModel: vendedorModel, errorModel: ErrorModel.empty());
}

class CadastroErrorState extends CadastroState {
  CadastroErrorState({required ErrorModel errorModel}) : super(vendedorModel: VendedorModel.empty(), errorModel: errorModel);
}