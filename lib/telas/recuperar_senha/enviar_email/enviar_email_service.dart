import 'package:app_cashback_soamer/app_widget/app_endpoints.dart';
import 'package:app_cashback_soamer/functions/api_connection.dart';

Future<Response> sendEmail(String email) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointRecuperarSenha,
    parameters: {"email": email},
  );
}
