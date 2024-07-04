import 'dart:convert';

import 'package:app_cashback_soamer/api/api_exception.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/api_connection.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/home_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';
import 'package:app_cashback_soamer/telas/home/inicio/inicio_service.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_event.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_service.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_state.dart';
import 'package:bloc/bloc.dart';

class VaucherBloc extends Bloc<VaucherEvent, VaucherState> {
  VaucherBloc() : super(VaucherInitialState()) {
    on<VaucherLoadEvent>((event, emit) async {
      emit(VaucherLoadingState());
      try {

        VendedorModel usuarioModel = await getModelLocal();

        List<VaucherModel> lista = [];
        List<VaucherModel> lista2 = [];
        List<VaucherModel> lista3 = [];

        Response responseUsuario = await getDadosRecompensa(usuarioModel.email!);
        Response response = await getVaucher();
        Response responseVaucherPromocao = await getVaucherPromocao();
        Response responseVaucherMaisTrocados = await getVaucherMaisTrocados();

        for (var voucher in jsonDecode(response.body)) {
          var vaucherModel = VaucherModel.fromMap(voucher);
          lista.add(vaucherModel);
        }

        for (var voucher in jsonDecode(responseVaucherPromocao.body)) {
          var vaucherModel = VaucherModel.fromMap(voucher);
          lista2.add(vaucherModel);
        }

        for (var voucher in jsonDecode(responseVaucherMaisTrocados.body)) {
          var vaucherModel = VaucherModel.fromMap(voucher);
          lista3.add(vaucherModel);
        }

        emit(VaucherSuccessState(vaucherModel: lista, vaucherModelListMaisTrocados: lista3, vaucherModelListPromocao: lista2, dadosUsuarioModel: HomeModel.fromMap(jsonDecode(responseUsuario.body))));
      } catch (e) {
        emit(VaucherErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });
  }
}
