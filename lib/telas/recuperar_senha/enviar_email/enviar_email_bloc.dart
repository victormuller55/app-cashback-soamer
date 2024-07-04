import 'dart:convert';

import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/api/api_exception.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_strings.dart';
import 'package:app_cashback_soamer/app_widget/snack_bar/snack_bar.dart';
import 'package:app_cashback_soamer/functions/navigation.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_event.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_service.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_state.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/verificar_codigo/verificar_codigo_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class EnviarEmailBloc extends Bloc<EnviarEmailEvent, EnviarEmailState> {
  EnviarEmailBloc() : super(EnviarEmailInitialState()) {
    on<EnviarEmailSendEvent>((event, emit) async {
      emit(EnviarEmailLoadingState());
      try {
        Response response = await sendEmail(event.email);
        emit(EnviarEmailSuccessState(code: response.body));
        showSnackbarSuccess(message: AppStrings.emailEnviado);
        open(screen: VerificarCodigoScreen(email: event.email, code: state.code));

      } catch (e) {
        emit(EnviarEmailErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });
  }
}