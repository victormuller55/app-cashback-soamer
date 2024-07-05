

import 'package:muller_package/muller_package.dart';

abstract class VoucherState {
  ErrorModel errorModel;
  String code;

  VoucherState({required this.code, required this.errorModel});
}

class VoucherInitialState extends VoucherState {
  VoucherInitialState() : super(code: "", errorModel: ErrorModel.empty());
}

class VoucherLoadingState extends VoucherState {
  VoucherLoadingState() : super(code: "", errorModel: ErrorModel.empty());
}

class VoucherSuccessState extends VoucherState {
  VoucherSuccessState({required String code}) : super(code: code, errorModel: ErrorModel.empty());
}

class VoucherErrorState extends VoucherState {
  VoucherErrorState({required ErrorModel errorModel}) : super(code: "", errorModel: errorModel);
}