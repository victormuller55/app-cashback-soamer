import 'package:app_cashback_soamer/models/extrato_model.dart';
import 'package:muller_package/muller_package.dart';

abstract class ExtratoState {
  ErrorModel errorModel;
  List<ExtratoModel> extratoModel;

  ExtratoState({required this.extratoModel, required this.errorModel});
}

class ExtratoInitialState extends ExtratoState {
  ExtratoInitialState() : super(extratoModel: [], errorModel: ErrorModel.empty());
}

class ExtratoLoadingState extends ExtratoState {
  ExtratoLoadingState() : super(extratoModel: [ExtratoModel.empty()], errorModel: ErrorModel.empty());
}

class ExtratoSuccessState extends ExtratoState {
  ExtratoSuccessState({required List<ExtratoModel> extratoModel}) : super(extratoModel: extratoModel, errorModel: ErrorModel.empty());
}

class ExtratoErrorState extends ExtratoState {
  ExtratoErrorState({required ErrorModel errorModel}) : super(extratoModel: [ExtratoModel.empty()], errorModel: errorModel);
}