import 'dart:convert';
import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/api/api_exception.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_event.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_service.dart';
import 'package:app_cashback_soamer/telas/entrar/entrar_state.dart';
import 'package:app_cashback_soamer/telas/home/home_screen.dart';
import 'package:bloc/bloc.dart';

class EntrarBloc extends Bloc<EntrarEvent, EntrarState> {
  EntrarBloc() : super(EntrarInitialState()) {
    on<EntrarLoginEvent>((event, emit) async {
      emit(EntrarLoadingState());
      try {

        Response response = await getUser(event.email, event.senha);
        VendedorModel usuarioModel = VendedorModel.fromMap(jsonDecode(response.body));
        saveLocalUserData(usuarioModel);

        if (state.usuarioModel.nomeConcessionaria != null || state.usuarioModel.nomeConcessionaria != "") {
          addLocalDataString("nome_concessionaria", state.usuarioModel.nomeConcessionaria ?? "");
        }

        open(screen: HomeScreen(usuarioModel: state.usuarioModel), closePrevious: true);

        emit(EntrarSuccessState(usuarioModel:usuarioModel));
      } catch (e) {
        showSnackbarError(message: state.errorModel.mensagem);
        emit(EntrarErrorState(errorModel: ApiException.errorModel(e)));
      }
    });
  }
}
