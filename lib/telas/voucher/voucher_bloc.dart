import 'package:muller_package/muller_package.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:app_cashback_soamer/telas/voucher/voucher_event.dart';
import 'package:app_cashback_soamer/telas/voucher/voucher_service.dart';
import 'package:app_cashback_soamer/telas/voucher/voucher_state.dart';
import 'package:bloc/bloc.dart';

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  VoucherBloc() : super(VoucherInitialState()) {
    on<VoucherTrocarEvent>((event, emit) async {
      emit(VoucherLoadingState());
      try {

        VendedorModel vendedorModel = await getModelLocal();
        AppResponse response = await getCodeVoucher(event.idVoucher, vendedorModel.id!);

        emit(VoucherSuccessState(code: response.body));
      } catch (e) {

        emit(VoucherErrorState(errorModel: ApiException.errorModel(e)));
      }
    });
  }
}