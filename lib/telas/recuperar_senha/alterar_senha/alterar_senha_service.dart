import 'package:muller_package/muller_package.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';

Future<AppResponse> alterarSenha(String email, String novaSenha) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointEntrarCadastrar,
    parameters: {
      "email": email,
      "nova_senha": novaSenha,
      "senha": "",
    },
  );
}
