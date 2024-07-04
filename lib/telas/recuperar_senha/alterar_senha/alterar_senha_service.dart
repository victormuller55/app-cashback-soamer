import 'package:app_cashback_soamer/app_widget/app_endpoints.dart';
import 'package:app_cashback_soamer/functions/api_connection.dart';

Future<Response> alterarSenha(String email, String novaSenha) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointEntrarCadastrar,
    parameters: {
      "email": email,
      "nova_senha": novaSenha,
      "senha": "",
    },
  );
}
