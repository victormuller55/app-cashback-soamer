import 'package:app_cashback_soamer/models/error_model.dart';

abstract class RegistrarVendaState {
  ErrorModel errorModel;

  RegistrarVendaState({required this.errorModel});
}

class RegistrarVendaInitialState extends RegistrarVendaState {
  RegistrarVendaInitialState() : super(errorModel: ErrorModel.empty());
}

class RegistrarVendaLoadingState extends RegistrarVendaState {
  RegistrarVendaLoadingState() : super(errorModel: ErrorModel.empty());
}

class RegistrarVendaSuccessState extends RegistrarVendaState {
  RegistrarVendaSuccessState() : super(errorModel: ErrorModel.empty());
}

class RegistrarVendaErrorState extends RegistrarVendaState {
  RegistrarVendaErrorState({required ErrorModel errorModel}) : super(errorModel: errorModel);
}
