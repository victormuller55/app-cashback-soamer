import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:muller_package/muller_package.dart';

abstract class EditarVendedorState {
  VendedorModel vendedorModel;
  ErrorModel errorModel;

  EditarVendedorState({required this.vendedorModel, required this.errorModel});
}

class EditarVendedorInitialState extends EditarVendedorState {
  EditarVendedorInitialState() : super(vendedorModel: VendedorModel.empty(), errorModel: ErrorModel.empty());
}

class EditarVendedorLoadingState extends EditarVendedorState {
  EditarVendedorLoadingState() : super(vendedorModel: VendedorModel.empty(), errorModel: ErrorModel.empty());
}

class EditarVendedorSuccessState extends EditarVendedorState {
  EditarVendedorSuccessState({required VendedorModel vendedorModel}) : super(vendedorModel: vendedorModel, errorModel: ErrorModel.empty());
}

class EditarVendedorErrorState extends EditarVendedorState {
  EditarVendedorErrorState({required ErrorModel errorModel}) : super(vendedorModel: VendedorModel.empty(), errorModel: errorModel);
}
