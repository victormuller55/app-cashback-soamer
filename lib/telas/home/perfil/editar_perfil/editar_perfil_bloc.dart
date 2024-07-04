import 'dart:convert';
import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/api/api_exception.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_event.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_service.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_state.dart';
import 'package:bloc/bloc.dart';

class EditarVendedorBloc extends Bloc<EditarVendedorEvent, EditarVendedorState> {
  EditarVendedorBloc() : super(EditarVendedorInitialState()) {
    on<EditarVendedorSalvarEvent>((event, emit) async {
      emit(EditarVendedorLoadingState());
      try {

        VendedorModel vendedorModel = await getModelLocal();

        if(event.image.path.isNotEmpty) {
          await editarFotoVendedor(vendedorModel.id!, event.image);
        }

        Response response = await editarVendedor(event.editarVendedorModel);

        emit(EditarVendedorSuccessState(vendedorModel: VendedorModel.fromMap(jsonDecode(response.body)), concessionariaModelList: []));
      } catch (e) {
        emit(EditarVendedorErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });
  }
}
