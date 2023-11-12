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
        List<VaucherModel> vauchersPromocao = [];
        List<VaucherModel> vauchersMaisTrocados = [];

        // Faz requisições
        Response responseUsuario = await getHome(event.email);
        Response responseVaucherPromocao = await getVaucherPromocao();
        Response responseVaucherMaisTrocados = await getVaucherMaisTrocados();
        UsuarioModel usuarioModel = await getModelLocal();

        // Transforma json em model (Voucher em promoção)
        for (var voucher in jsonDecode(responseVaucherPromocao.body)) {
          var vaucherModel = VaucherModel.fromMap(voucher);
          vauchersPromocao.add(vaucherModel);
        }

        // Transforma json em model (Voucher em promoção)
        for (var voucher in jsonDecode(responseVaucherMaisTrocados.body)) {
          var vaucherModel = VaucherModel.fromMap(voucher);
          vauchersMaisTrocados.add(vaucherModel);
        }

        // Transforma json em model (Usuario)
        HomeModel homeModel = HomeModel.fromMap(jsonDecode(responseUsuario.body));

        // Set valores do usuario
        usuarioModel.valorPix = homeModel.valorPix;
        usuarioModel.pontosPedentesUsuario = homeModel.pontosPedentesUsuario;
        usuarioModel.pontosUsuario = homeModel.pontosUsuario;

        emit(InicioSuccessState(usuarioModel: usuarioModel, vaucherListPromocao: vauchersPromocao, vaucherListMaisTrocados: vauchersMaisTrocados, concessionariaList: []));
      } catch (e) {
        print(e);

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

        emit(InicioSuccessState(usuarioModel: UsuarioModel.empty(), vaucherListPromocao: [], vaucherListMaisTrocados: [], concessionariaList: itens));
      } catch (e) {
        emit(InicioErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });

    on<SetConcessionariaEvent>((event, emit) async {
      emit(InicioLoadingState());
      try {
        await setConcessionaria(event.idConcessionaria);
        emit(InicioSuccessState(usuarioModel: UsuarioModel.empty(), vaucherListPromocao: [], concessionariaList: [], vaucherListMaisTrocados: []));
      } catch (e) {
        emit(InicioErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });
  }
}
