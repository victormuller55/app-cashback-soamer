import 'dart:convert';

import 'package:muller_package/muller_package.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:app_cashback_soamer/telas/home/home_screen.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/alterar_senha/alterar_senha_event.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/alterar_senha/alterar_senha_service.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/alterar_senha/alterar_senha_state.dart';
import 'package:bloc/bloc.dart';

class AlterarSenhaBloc extends Bloc<AlterarSenhaEvent, AlterarSenhaState> {
  AlterarSenhaBloc() : super(AlterarSenhaInitialState()) {
    on<AlterarSenhaEnviarEvent>((event, emit) async {
      emit(AlterarSenhaLoadingState());
      try {

        AppResponse response = await alterarSenha(event.email, event.novaSenha);
        VendedorModel vendedorModel = VendedorModel.fromMap(jsonDecode(response.body));
        saveLocalUserData(vendedorModel);

        emit(AlterarSenhaSuccessState(vendedorModel: vendedorModel));

        if (vendedorModel.nomeConcessionaria != null || vendedorModel.nomeConcessionaria != "") {
          addLocalDataString("nome_concessionaria", vendedorModel.nomeConcessionaria ?? "");
        }

        open(screen: HomeScreen(vendedorModel: vendedorModel), closePrevious: true);

      } catch (e) {
        emit(AlterarSenhaErrorState(errorModel: ApiException.errorModel(e)));
      }
    });
  }
}