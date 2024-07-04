import 'package:app_cashback_soamer/models/concessionaria_model.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';

abstract class InicioState {
  VendedorModel vendedorModel;
  List<VaucherModel> vaucherListPromocao;
  List<VaucherModel> vaucherListMaisTrocados;
  List<ConcessionariaModel> concessionariaList;
  ErrorModel errorModel;

  InicioState({
    required this.vendedorModel,
    required this.vaucherListPromocao,
    required this.vaucherListMaisTrocados,
    required this.concessionariaList,
    required this.errorModel,
  });
}

class InicioInitialState extends InicioState {
  InicioInitialState()
      : super(
          vendedorModel: VendedorModel.empty(),
          errorModel: ErrorModel.empty(),
          vaucherListPromocao: [],
          vaucherListMaisTrocados: [],
          concessionariaList: [],
        );
}

class InicioLoadingState extends InicioState {
  InicioLoadingState()
      : super(
          vendedorModel: VendedorModel.empty(),
          errorModel: ErrorModel.empty(),
          vaucherListPromocao: [],
          vaucherListMaisTrocados: [],
          concessionariaList: [],
        );
}

class InicioSuccessState extends InicioState {
  InicioSuccessState({
    required VendedorModel vendedorModel,
    required List<VaucherModel> voucherListPromocao,
    required List<VaucherModel> voucherListMaisTrocados,
  }) : super(
          vendedorModel: vendedorModel,
          vaucherListPromocao: voucherListPromocao,
          vaucherListMaisTrocados: voucherListMaisTrocados,
          concessionariaList: [],
          errorModel: ErrorModel.empty(),
        );
}

class InicioSuccessConcessionariaLoadState extends InicioState {
  InicioSuccessConcessionariaLoadState({
    required List<ConcessionariaModel> concessionariaList,
  }) : super(
          vendedorModel: VendedorModel.empty(),
          vaucherListMaisTrocados: [],
          vaucherListPromocao: [],
          concessionariaList: concessionariaList,
          errorModel: ErrorModel.empty(),
        );
}

class InicioSuccessConcessionariaSaveState extends InicioState {
  InicioSuccessConcessionariaSaveState() : super(
    vendedorModel: VendedorModel.empty(),
    vaucherListMaisTrocados: [],
    vaucherListPromocao: [],
    concessionariaList: [],
    errorModel: ErrorModel.empty(),
  );
}

class InicioErrorState extends InicioState {
  InicioErrorState({required ErrorModel errorModel})
      : super(
          vendedorModel: VendedorModel.empty(),
          errorModel: errorModel,
          vaucherListPromocao: [],
          vaucherListMaisTrocados: [],
          concessionariaList: [],
        );
}
