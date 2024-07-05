import 'dart:convert';

import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/extrato_model.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:app_cashback_soamer/telas/home/extrato/extrato_event.dart';
import 'package:app_cashback_soamer/telas/home/extrato/extrato_service.dart';
import 'package:app_cashback_soamer/telas/home/extrato/extrato_state.dart';
import 'package:bloc/bloc.dart';
import 'package:muller_package/muller_package.dart';

class ExtratoBloc extends Bloc<ExtratoEvent, ExtratoState> {
  ExtratoBloc() : super(ExtratoInitialState()) {
    on<ExtratoLoadEvent>((event, emit) async {
      emit(ExtratoLoadingState());
      try {

        VendedorModel vendedorModel = await getModelLocal();

        AppResponse response = await getExtrato(vendedorModel.id ?? 0);
        List<ExtratoModel> extrato = [];

        for (var voucher in jsonDecode(response.body)) {
          var vaucherModel = ExtratoModel.fromMap(voucher);
          extrato.add(vaucherModel);
        }

        emit(ExtratoSuccessState(extratoModel: extrato));
      } catch (e) {
        emit(ExtratoErrorState(errorModel: ApiException.errorModel(e)));
      }
    });
  }
}