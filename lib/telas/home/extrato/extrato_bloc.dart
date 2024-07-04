import 'dart:convert';

import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/api/api_exception.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/extrato_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/home/extrato/extrato_event.dart';
import 'package:app_cashback_soamer/telas/home/extrato/extrato_service.dart';
import 'package:app_cashback_soamer/telas/home/extrato/extrato_state.dart';
import 'package:bloc/bloc.dart';

class ExtratoBloc extends Bloc<ExtratoEvent, ExtratoState> {
  ExtratoBloc() : super(ExtratoInitialState()) {
    on<ExtratoLoadEvent>((event, emit) async {
      emit(ExtratoLoadingState());
      try {

        VendedorModel usuarioModel = await getModelLocal();

        Response response = await getExtrato(usuarioModel.id ?? 0);
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