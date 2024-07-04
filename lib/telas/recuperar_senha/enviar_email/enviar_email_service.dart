
import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';

Future<Response> sendEmail(String email) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointRecuperarSenha,
    parameters: {"email": email},
  );
}
