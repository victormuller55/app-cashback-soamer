import 'dart:convert';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_event.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_service.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_state.dart';
import 'package:bloc/bloc.dart';
import 'package:muller_package/muller_package.dart';

class EditarVendedorBloc extends Bloc<EditarVendedorEvent, EditarVendedorState> {
  EditarVendedorBloc() : super(EditarVendedorInitialState()) {
    on<EditarVendedorSalvarEvent>((event, emit) async {
      emit(EditarVendedorLoadingState());
      try {

        VendedorModel vendedorModelLocal = await getModelLocal();

        if(event.image.path.isNotEmpty) {
          await editarFotoVendedor(vendedorModelLocal.id!, event.image);
        }

        AppResponse response = await editarVendedor(event.editarVendedorModel);
        VendedorModel vendedorModel = VendedorModel.fromMap(jsonDecode(response.body));

        emit(EditarVendedorSuccessState(vendedorModel: vendedorModel));

        saveLocalUserData(state.vendedorModel);
        showSnackbarSuccess(message: AppStrings.salvoComSucesso);

      } catch (e) {
        emit(EditarVendedorErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });
  }
}
