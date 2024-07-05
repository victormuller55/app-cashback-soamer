import 'dart:convert';

import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/home_model.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';
import 'package:app_cashback_soamer/telas/home/inicio/inicio_service.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_event.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_service.dart';
import 'package:app_cashback_soamer/telas/home/recompensas/recompensas_state.dart';
import 'package:muller_package/muller_package.dart';
import 'package:bloc/bloc.dart';


class VaucherBloc extends Bloc<VaucherEvent, VaucherState> {
  VaucherBloc() : super(VaucherInitialState()) {
    on<VaucherLoadEvent>((event, emit) async {
      emit(VaucherLoadingState());
      try {

        VendedorModel vendedorModel = await getModelLocal();

        List<VaucherModel> lista = [];
        List<VaucherModel> lista2 = [];
        List<VaucherModel> lista3 = [];

        AppResponse responseVendedor = await getDadosRecompensa(vendedorModel.email!);
        AppResponse response = await getVaucher();
        AppResponse responseVaucherPromocao = await getVaucherPromocao();
        AppResponse responseVaucherMaisTrocados = await getVaucherMaisTrocados();

        for (var voucher in jsonDecode(response.body)) {
          var voucherModel = VaucherModel.fromMap(voucher);
          lista.add(voucherModel);
        }

        for (var voucher in jsonDecode(responseVaucherPromocao.body)) {
          var vaucherModel = VaucherModel.fromMap(voucher);
          lista2.add(vaucherModel);
        }

        for (var voucher in jsonDecode(responseVaucherMaisTrocados.body)) {
          var vaucherModel = VaucherModel.fromMap(voucher);
          lista3.add(vaucherModel);
        }

        emit(VaucherSuccessState(vaucherModel: lista, vaucherModelListMaisTrocados: lista3, vaucherModelListPromocao: lista2, dadosVendedorModel: HomeModel.fromMap(jsonDecode(responseVendedor.body))));
      } catch (e) {
        emit(VaucherErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });
  }
}
