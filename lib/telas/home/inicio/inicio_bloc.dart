import 'dart:convert';

import 'package:app_cashback_soamer/app_widget/api_exception.dart';
import 'package:app_cashback_soamer/functions/service.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/home_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';
import 'package:app_cashback_soamer/telas/home/inicio/inicio_event.dart';
import 'package:app_cashback_soamer/telas/home/inicio/inicio_service.dart';
import 'package:app_cashback_soamer/telas/home/inicio/inicio_state.dart';
import 'package:bloc/bloc.dart';

class InicioBloc extends Bloc<InicioEvent, InicioState> {
  InicioBloc() : super(InicioInitialState()) {
    on<InicioLoadEvent>((event, emit) async {
      emit(InicioLoadingState());
      try {
        Response response = await getHome(event.email);
        emit(InicioSuccessState(homeModel: HomeModel.fromMap(jsonDecode(response.body)), vaucherList: []));
      } catch (e) {
        emit(InicioErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });

    on<LoadVaucherPromocaoEvent>((event, emit) async {
      emit(InicioLoadingState());
      try {

        Response response = await getVaucherPromocao();
        List<VaucherModel> itens = [];

        for (var voucher in jsonDecode(response.body)) {
          var vaucherModel = VaucherModel.fromMap(voucher);
          itens.add(vaucherModel);
        }

        emit(InicioSuccessState(homeModel: HomeModel.empty(), vaucherList: itens));
      } catch (e) {
        emit(InicioErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });
  }
}
