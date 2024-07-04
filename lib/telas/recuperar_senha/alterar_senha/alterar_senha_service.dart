
import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';

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
