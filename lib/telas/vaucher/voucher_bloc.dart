import 'dart:convert';

import 'package:app_cashback_soamer/api/api_exception.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/api_connection.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/vaucher/voucher_event.dart';
import 'package:app_cashback_soamer/telas/vaucher/voucher_service.dart';
import 'package:app_cashback_soamer/telas/vaucher/voucher_state.dart';
import 'package:bloc/bloc.dart';

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  VoucherBloc() : super(VoucherInitialState()) {
    on<VoucherTrocarEvent>((event, emit) async {
      emit(VoucherLoadingState());
      try {
        VendedorModel usuarioModel = await getModelLocal();
        Response response = await getCodeVoucher(event.idVoucher, usuarioModel.id!);
        emit(VoucherSuccessState(code: response.body));
      } catch (e) {
        emit(VoucherErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });
  }
}