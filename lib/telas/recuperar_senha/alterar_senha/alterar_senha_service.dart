import 'package:app_cashback_soamer/app_widget/endpoints.dart';
import 'package:app_cashback_soamer/functions/service.dart';

Future<Response> alterarSenha(String email, String novaSenha) async {
  return await getHTTP(
    endpoint: Endpoint.endpointEntrarCadastrar,
    parameters: {
      "email": email,
      "nova_senha": novaSenha,
      "senha": "",
    },
  );
}
