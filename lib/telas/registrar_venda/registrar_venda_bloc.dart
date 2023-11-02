import 'dart:convert';

import 'package:app_cashback_soamer/app_widget/api_exception.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
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
        UsuarioModel usuarioModel = await getModelLocal();
        VendaModel vendaModel = VendaModel(idUsuario: usuarioModel.idUsuario!, vendaNfeCode: event.nfc);
        await registrarVenda(vendaModel);
        emit(RegistrarVendaSuccessState());
      } catch (e) {
        emit(RegistrarVendaErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });
  }
}
