import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_event.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_service.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/enviar_email/enviar_email_state.dart';
import 'package:app_cashback_soamer/telas/recuperar_senha/verificar_codigo/verificar_codigo_screen.dart';
import 'package:muller_package/muller_package.dart';
import 'package:bloc/bloc.dart';

class EnviarEmailBloc extends Bloc<EnviarEmailEvent, EnviarEmailState> {
  EnviarEmailBloc() : super(EnviarEmailInitialState()) {
    on<EnviarEmailSendEvent>((event, emit) async {
      emit(EnviarEmailLoadingState());
      try {
        AppResponse response = await sendEmail(event.email);
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