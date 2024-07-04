import 'dart:convert';

import 'package:app_cashback_soamer/api/api_exception.dart';
import 'package:app_cashback_soamer/functions/api_connection.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/alterar_senha/alterar_senha_event.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/alterar_senha/alterar_senha_service.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/alterar_senha/alterar_senha_state.dart';
import 'package:bloc/bloc.dart';

class AlterarSenhaBloc extends Bloc<AlterarSenhaEvent, AlterarSenhaState> {
  AlterarSenhaBloc() : super(AlterarSenhaInitialState()) {
    on<AlterarSenhaEnviarEvent>((event, emit) async {
      emit(AlterarSenhaLoadingState());
      try {
        Response response = await alterarSenha(event.email, event.novaSenha);
        emit(AlterarSenhaSuccessState(usuarioModel: VendedorModel.fromMap(jsonDecode(response.body))));
      } catch (e) {
        emit(AlterarSenhaErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });
  }
}