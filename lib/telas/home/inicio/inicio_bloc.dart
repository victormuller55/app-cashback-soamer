import 'dart:convert';

import 'package:app_cashback_soamer/app_widget/api_exception.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/service.dart';
import 'package:app_cashback_soamer/models/concessionaria_model.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/home_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
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

        List<VaucherModel> vauchers = [];

        // Faz requisições
        Response responseUsuario = await getHome(event.email);
        Response responseVaucher = await getVaucherPromocao();
        UsuarioModel usuarioModel = await getModelLocal();

        // Transforma json em model (Voucher)
        for (var voucher in jsonDecode(responseVaucher.body)) {
          var vaucherModel = VaucherModel.fromMap(voucher);
          vauchers.add(vaucherModel);
        }
        // Transforma json em model (Usuario)
        HomeModel homeModel = HomeModel.fromMap(jsonDecode(responseUsuario.body));

        // Set valores do usuario
        usuarioModel.valorPix = homeModel.valorPix;
        usuarioModel.pontosPedentesUsuario = homeModel.pontosPedentesUsuario;
        usuarioModel.pontosUsuario = homeModel.pontosUsuario;

        print(responseUsuario.body);

        emit(InicioSuccessState(usuarioModel: usuarioModel, vaucherListPromocao: vauchers, concessionariaList: []));
      } catch (e) {
        emit(InicioErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });

    on<LoadConcessionariaEvent>((event, emit) async {
      emit(InicioLoadingState());
      try {
        Response response = await getConcessionarias();
        List<ConcessionariaModel> itens = [];

        for (var voucher in jsonDecode(response.body)) {
          var vaucherModel = ConcessionariaModel.fromMap(voucher);
          itens.add(vaucherModel);
        }

        emit(InicioSuccessState(usuarioModel: UsuarioModel.empty(), vaucherListPromocao: [], concessionariaList: itens));
      } catch (e) {
        emit(InicioErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });

    on<SetConcessionariaEvent>((event, emit) async {
      emit(InicioLoadingState());
      try {
        await setConcessionaria(event.idConcessionaria);
        emit(InicioSuccessState(usuarioModel: UsuarioModel.empty() ,vaucherListPromocao: [], concessionariaList: []));
      } catch (e) {
        emit(InicioErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });
  }
}
