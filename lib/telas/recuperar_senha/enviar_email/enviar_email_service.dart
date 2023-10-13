import 'package:app_cashback_soamer/app_widget/endpoints.dart';
import 'package:app_cashback_soamer/functions/service.dart';

Future<Response> sendEmail(String email) async {
  return await getHTTP(
    endpoint: Endpoint.endpointRecuperarSenha,
    parameters: {"email": email},
  );
}
