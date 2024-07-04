import 'dart:convert';

import 'package:app_cashback_soamer/api/api_exception.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:app_cashback_soamer/models/venda_model.dart';
import 'package:app_cashback_soamer/telas/registrar_venda/registrar_venda_event.dart';
import 'package:app_cashback_soamer/telas/registrar_venda/registrar_venda_service.dart';
import 'package:app_cashback_soamer/telas/registrar_venda/registrar_venda_state.dart';
import 'package:bloc/bloc.dart';

class RegistrarVendaBloc extends Bloc<RegistrarVendaEvent, RegistrarVendaState> {
  RegistrarVendaBloc() : super(RegistrarVendaInitialState()) {
    on<RegistrarVendaLoadEvent>((event, emit) async {
      emit(RegistrarVendaLoadingState());
      try {
        VendedorModel vendedorModel = await getModelLocal();
        VendaModel vendaModel = VendaModel(idVendedor: vendedorModel.id!, nfeCode: event.nfc, idPonteira: event.idPonteira);
        await registrarVenda(vendaModel);
        emit(RegistrarVendaSuccessState());
      } catch (e) {
        emit(RegistrarVendaErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });
  }
}
