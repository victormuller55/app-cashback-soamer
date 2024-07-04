import 'dart:convert';

import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/api/api_exception.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/concessionaria_model.dart';
import 'package:app_cashback_soamer/models/home_model.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
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
        List<VaucherModel> vouchersPromocao = [];
        List<VaucherModel> vouchersMaisTrocados = [];

        // Faz requisições
        Response responseVendedor = await getHome(event.email);
        Response responseVaucherPromocao = await getVaucherPromocao();
        Response responseVaucherMaisTrocados = await getVaucherMaisTrocados();
        VendedorModel vendedorModel = await getModelLocal();

        // Transforma json em model (Voucher em promoção)
        for (var voucher in jsonDecode(responseVaucherPromocao.body)) {
          var vaucherModel = VaucherModel.fromMap(voucher);
          vouchersPromocao.add(vaucherModel);
        }

        // Transforma json em model (Voucher em promoção)
        for (var voucher in jsonDecode(responseVaucherMaisTrocados.body)) {
          var vaucherModel = VaucherModel.fromMap(voucher);
          vouchersMaisTrocados.add(vaucherModel);
        }

        // Transforma json em model (Vendedor)
        HomeModel homeModel = HomeModel.fromMap(jsonDecode(responseVendedor.body));

        // Set valores do usuario
        vendedorModel.valorPix = homeModel.valorPix;

        vendedorModel.pontosPendentes = homeModel.pontosPendentes;
        vendedorModel.pontos = homeModel.pontos;

        emit(
          InicioSuccessState(
            vendedorModel: vendedorModel,
            voucherListPromocao: vouchersPromocao,
            voucherListMaisTrocados: vouchersMaisTrocados,
          ),
        );

      } catch (e) {
        emit(InicioErrorState(errorModel: ApiException.errorModel(e)));
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

        emit(InicioSuccessConcessionariaLoadState(concessionariaList: itens));
      } catch (e) {
        emit(InicioErrorState(errorModel: ApiException.errorModel(e)));
      }
    });

    on<SetConcessionariaEvent>((event, emit) async {
      emit(InicioLoadingState());
      try {
        await setConcessionaria(event.idConcessionaria);
        emit(InicioSuccessConcessionariaSaveState());
      } catch (e) {
        emit(InicioErrorState(errorModel: ApiException.errorModel(e)));
      }
    });
  }
}
