import 'dart:convert';

import 'package:app_cashback_soamer/functions/service.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_event.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_service.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_state.dart';
import 'package:bloc/bloc.dart';

class VaucherBloc extends Bloc<VaucherEvent, VaucherState> {
  VaucherBloc() : super(VaucherInitialState(contaModel: [], errorModel: ErrorModel.empty())) {
    on<VaucherLoadEvent>((event, emit) async {
      emit(VaucherLoadingState(vaucherModel: [], errorModel: ErrorModel.empty()));
      Response response = Response(statusCode: 0, body: "");
      try {
        response = await getVaucher();
        List<VaucherModel> itens = [];

        for (var voucher in jsonDecode(response.body)) {
          itens.add(jsonDecode(voucher));
        }

        if (response.statusCode == 200) {
          emit(VaucherSuccessState(vaucherModel: itens, errorModel: ErrorModel.fromMap(jsonDecode(response.body))));
        } else {
          emit(VaucherErrorState(vaucherModel: [], errorModel: ErrorModel.fromMap(jsonDecode(response.body))));
        }
      } catch (e) {
        emit(VaucherErrorState(vaucherModel: [], errorModel: ErrorModel.fromMap(jsonDecode(response.body))));
      }
    });
  }
}
