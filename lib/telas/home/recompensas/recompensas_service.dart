import 'package:app_cashback_soamer/app_widget/app_endpoints.dart';
import 'package:app_cashback_soamer/functions/api_connection.dart';

Future<Response> getVaucher() async {
  return await getHTTP(endpoint: AppEndpoints.endpointVaucher);
}

Future<Response> getDadosRecompensa(String email) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointHome,
    parameters: {"email": email},
  );
}