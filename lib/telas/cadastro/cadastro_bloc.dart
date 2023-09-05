import 'dart:convert';

import 'package:app_cashback_soamer/functions/service.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_event.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_service.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_state.dart';
import 'package:bloc/bloc.dart';

class CadastroBloc extends Bloc<CadastroEvent, CadastroState> {
  CadastroBloc() : super(CadastroInitialState(contaModel: UsuarioModel.empty(), errorModel: ErrorModel.empty())) {
    on<CadastroSalvarEvent>((event, emit) async {
      emit(CadastroLoadingState(contaModel: UsuarioModel.empty(), errorModel: ErrorModel.empty()));
      Response response = Response(statusCode: 0, body: "");
      try {
        response = await postUser(event.usuarioModel);
        if(response.statusCode == 200) {
          emit(CadastroSuccessState(usuarioModel: UsuarioModel.fromMap(jsonDecode(response.body)), errorModel: ErrorModel.empty()));
        } else {
          emit(CadastroErrorState(contaModel: UsuarioModel.empty(), errorModel: ErrorModel.fromMap(jsonDecode(response.body))));
        }
      } catch (e) {
        emit(CadastroErrorState(contaModel: UsuarioModel.empty(), errorModel: ErrorModel.fromMap(jsonDecode(response.body))));
      }
    });
  }
}
