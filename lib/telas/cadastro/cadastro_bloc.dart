import 'dart:convert';

import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/api/api_exception.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:app_cashback_soamer/telas/apresentacao/apresentacao_screen.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_event.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_service.dart';
import 'package:app_cashback_soamer/telas/cadastro/cadastro_state.dart';
import 'package:bloc/bloc.dart';

class CadastroBloc extends Bloc<CadastroEvent, CadastroState> {
  CadastroBloc() : super(CadastroInitialState()) {
    on<CadastroSalvarEvent>((event, emit) async {
      emit(CadastroLoadingState());
      try {

        Response response = await postUser(event.vendedorModel);
        VendedorModel vendedorModel = VendedorModel.fromMap(jsonDecode(response.body));
        saveLocalUserData(vendedorModel);

        open(screen: ApresentacaoScreen(vendedorModel: vendedorModel), closePrevious: true);

        emit(CadastroSuccessState(vendedorModel: vendedorModel));

        if (vendedorModel.nomeConcessionaria != null || vendedorModel.nomeConcessionaria != "") {
          addLocalDataString("nome_concessionaria", vendedorModel.nomeConcessionaria ?? "");
        }
      } catch (e) {
        emit(CadastroErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });
  }
}
