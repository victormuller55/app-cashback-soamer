import 'dart:convert';

import 'package:app_cashback_soamer/functions/service.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_event.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_service.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_state.dart';
import 'package:bloc/bloc.dart';

class EntrarBloc extends Bloc<EntrarEvent, EntrarState> {
  EntrarBloc() : super(EntrarInitialState(contaModel: UsuarioModel.empty(), errorModel: ErrorModel.empty())) {
    on<EntrarLoginEvent>((event, emit) async {
      emit(EntrarLoadingState(contaModel: UsuarioModel.empty(), errorModel: ErrorModel.empty()));
      Response response = Response(statusCode: 0, body: "");
      try {
        response = await getUser(event.email, event.senha);
        if (response.statusCode == 200) {
          emit(EntrarSuccessState(usuarioModel: UsuarioModel.fromMap(jsonDecode(response.body)), errorModel: ErrorModel.empty()));
        } else {
          emit(EntrarErrorState(contaModel: UsuarioModel.empty(), errorModel: ErrorModel.fromMap(jsonDecode(response.body))));
        }
      } catch (e) {
        emit(EntrarErrorState(contaModel: UsuarioModel.empty(), errorModel: ErrorModel.fromMap(jsonDecode(response.body))));
      }
    });
  }
}
