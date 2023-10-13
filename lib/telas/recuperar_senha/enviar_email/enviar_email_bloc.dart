import 'dart:convert';

import 'package:app_cashback_soamer/app_widget/api_exception.dart';
import 'package:app_cashback_soamer/functions/service.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_event.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_service.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class EnviarEmailBloc extends Bloc<EnviarEmailEvent, EnviarEmailState> {
  EnviarEmailBloc() : super(EnviarEmailInitialState()) {
    on<EnviarEmailSendEvent>((event, emit) async {
      emit(EnviarEmailLoadingState());
      try {
        Response response = await sendEmail(event.email);
        if (kDebugMode) {
          print(response.body);
        }
        emit(EnviarEmailSuccessState(code: response.body));
      } catch (e) {
        emit(EnviarEmailErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
      }
    });
  }
}