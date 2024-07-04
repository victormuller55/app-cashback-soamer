import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_strings.dart';

Future<Response> getUser(String email, String senha) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointEntrarCadastrar,
    parameters: {
      "email": email,
      "senha": senha,
      "nova_senha": AppStrings.vazio,
    },
  );
}
