import 'dart:convert';

import 'package:app_cashback_soamer/app_widget/api_exception.dart';
import 'package:app_cashback_soamer/functions/service.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_event.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_service.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_state.dart';
import 'package:bloc/bloc.dart';

class CadastroBloc extends Bloc<CadastroEvent, CadastroState> {
  CadastroBloc() : super(CadastroInitialState()) {
    on<CadastroSalvarEvent>((event, emit) async {
      emit(CadastroLoadingState());
      // try {
        Response response = await postUser(event.usuarioModel);
        emit(CadastroSuccessState(usuarioModel: UsuarioModel.fromMap(jsonDecode(response.body))));
      // } catch (e) {
        // emit(CadastroErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      // }
    });
  }
}
