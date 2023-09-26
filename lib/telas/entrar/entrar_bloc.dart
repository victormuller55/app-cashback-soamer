import 'dart:convert';
import 'package:app_cashback_soamer/app_widget/api_exception.dart';
import 'package:app_cashback_soamer/functions/service.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_event.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_service.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_state.dart';
import 'package:bloc/bloc.dart';

class EntrarBloc extends Bloc<EntrarEvent, EntrarState> {
  EntrarBloc() : super(EntrarInitialState()) {
    on<EntrarLoginEvent>((event, emit) async {
      emit(EntrarLoadingState());
      try {
        Response response = await getUser(event.email, event.senha);
        emit(EntrarSuccessState(usuarioModel: UsuarioModel.fromMap(jsonDecode(response.body))));
      } catch (e) {
        emit(EntrarErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });
  }
}
