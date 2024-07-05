import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:muller_package/muller_package.dart';

abstract class EntrarState {
  ErrorModel errorModel;
  VendedorModel vendedorModel;

  EntrarState({required this.vendedorModel, required this.errorModel});
}

class EntrarInitialState extends EntrarState {
  EntrarInitialState() : super(vendedorModel: VendedorModel.empty(), errorModel: ErrorModel.empty());
}

class EntrarLoadingState extends EntrarState {
  EntrarLoadingState() : super(vendedorModel: VendedorModel.empty(), errorModel: ErrorModel.empty());
}

class EntrarSuccessState extends EntrarState {
  EntrarSuccessState({required VendedorModel vendedorModel}) : super(vendedorModel: vendedorModel, errorModel: ErrorModel.empty());
}

class EntrarErrorState extends EntrarState {
  EntrarErrorState({required ErrorModel errorModel}) : super(vendedorModel: VendedorModel.empty(), errorModel: errorModel);
}
