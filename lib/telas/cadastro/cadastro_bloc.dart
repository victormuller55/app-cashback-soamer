import 'dart:convert';

import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/api/api_exception.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
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

        Response response = await postUser(event.usuarioModel);
        VendedorModel usuarioModel = VendedorModel.fromMap(jsonDecode(response.body));
        saveLocalUserData(usuarioModel);

        if (state.usuarioModel.nomeConcessionaria != null || state.usuarioModel.nomeConcessionaria != "") {
          addLocalDataString("nome_concessionaria", state.usuarioModel.nomeConcessionaria ?? "");
        }

        open(screen: ApresentacaoScreen(usuarioModel: usuarioModel), closePrevious: true);

        emit(CadastroSuccessState(usuarioModel: usuarioModel));
      } catch (e) {
        showSnackbarError(message: state.errorModel.mensagem);
        emit(CadastroErrorState(errorModel: ApiException.errorModel(e)));
      }
    });
  }
}
