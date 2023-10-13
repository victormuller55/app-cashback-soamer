import 'package:app_cashback_soamer/models/error_model.dart';

abstract class EnviarEmailState {
  ErrorModel errorModel;
  String code;

  EnviarEmailState({required this.code, required this.errorModel});
}

class EnviarEmailInitialState extends EnviarEmailState {
  EnviarEmailInitialState() : super(code: "", errorModel: ErrorModel.empty());
}

class EnviarEmailLoadingState extends EnviarEmailState {
  EnviarEmailLoadingState() : super(code: "", errorModel: ErrorModel.empty());
}

class EnviarEmailSuccessState extends EnviarEmailState {
  EnviarEmailSuccessState({required String code}) : super(code: code, errorModel: ErrorModel.empty());
}

class EnviarEmailErrorState extends EnviarEmailState {
  EnviarEmailErrorState({required ErrorModel errorModel}) : super(code: "", errorModel: errorModel);
}