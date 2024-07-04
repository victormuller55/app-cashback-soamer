import 'dart:convert';
import 'package:app_cashback_soamer/api/api_exception.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/api_connection.dart';
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

        VendedorModel usuarioModel = await getModelLocal();

        if(event.image.path.isNotEmpty) {
          await editarFotoUsuario(usuarioModel.id!, event.image);
        }

        Response response = await editarUsuario(event.editUsuarioModel);

        emit(EditarUsuarioSuccessState(usuarioModel: VendedorModel.fromMap(jsonDecode(response.body)), concessionariaModelList: []));
      } catch (e) {
        emit(EditarUsuarioErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });
  }
}
