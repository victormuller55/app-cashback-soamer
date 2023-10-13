import 'dart:convert';

import 'package:app_cashback_soamer/app_widget/api_exception.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/service.dart';
import 'package:app_cashback_soamer/models/concessionaria_model.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_event.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_service.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_state.dart';
import 'package:bloc/bloc.dart';

class EditarUsuarioBloc extends Bloc<EditarUsuarioEvent, EditarUsuarioState> {
  EditarUsuarioBloc() : super(EditarUsuarioInitialState()) {
    on<EditarUsuarioSalvarEvent>((event, emit) async {
      emit(EditarUsuarioLoadingState());
      try {
        UsuarioModel usuarioModel = await getModelLocal();
        if(event.image.path.isNotEmpty) {
          await editarFotoUsuario(usuarioModel.idUsuario!, event.image);
        }
        Response response = await editarUsuario(event.editUsuarioModel);
        emit(EditarUsuarioSuccessState(usuarioModel: UsuarioModel.fromMap(jsonDecode(response.body)), concessionariaModelList: []));
      } catch (e) {
        print(e);
        emit(EditarUsuarioErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });
  }
}
