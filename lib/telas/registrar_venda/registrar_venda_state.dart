import 'package:app_cashback_soamer/models/error_model.dart';

abstract class RegistrarVendaState {
  ErrorModel errorModel;
  String pdfBytes;

  RegistrarVendaState({required this.pdfBytes, required this.errorModel});
}

class RegistrarVendaInitialState extends RegistrarVendaState {
  RegistrarVendaInitialState() : super(pdfBytes: "", errorModel: ErrorModel.empty());
}

class RegistrarVendaLoadingState extends RegistrarVendaState {
  RegistrarVendaLoadingState() : super(pdfBytes: "",errorModel: ErrorModel.empty());
}

class RegistrarVendaSuccessState extends RegistrarVendaState {
  RegistrarVendaSuccessState({required String pdfBytes}) : super(pdfBytes: pdfBytes, errorModel: ErrorModel.empty());
}

class RegistrarVendaErrorState extends RegistrarVendaState {
  RegistrarVendaErrorState({required ErrorModel errorModel}) : super(pdfBytes: "", errorModel: errorModel);
}
