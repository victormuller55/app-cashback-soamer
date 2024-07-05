import 'package:muller_package/muller_package.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';

Future<AppResponse> getUser(String email, String senha) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointEntrarCadastrar,
    parameters: {
      "email": email,
      "senha": senha,
      "nova_senha": AppStrings.vazio,
    },
  );
}
