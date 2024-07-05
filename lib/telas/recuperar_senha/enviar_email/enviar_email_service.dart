import 'package:muller_package/muller_package.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';

Future<AppResponse> sendEmail(String email) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointRecuperarSenha,
    parameters: {"email": email},
  );
}
