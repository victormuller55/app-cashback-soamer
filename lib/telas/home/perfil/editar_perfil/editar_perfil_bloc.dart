import 'dart:convert';
import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/api/api_exception.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_context.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_strings.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_event.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_service.dart';
import 'package:app_cashback_soamer/telas/home/perfil/editar_perfil/editar_perfil_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class EditarVendedorBloc extends Bloc<EditarVendedorEvent, EditarVendedorState> {
  EditarVendedorBloc() : super(EditarVendedorInitialState()) {
    on<EditarVendedorSalvarEvent>((event, emit) async {
      emit(EditarVendedorLoadingState());
      try {

        VendedorModel vendedorModelLocal = await getModelLocal();

        if(event.image.path.isNotEmpty) {
          await editarFotoVendedor(vendedorModelLocal.id!, event.image);
        }

        Response response = await editarVendedor(event.editarVendedorModel);
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
