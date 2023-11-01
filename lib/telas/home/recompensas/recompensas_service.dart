import 'package:app_cashback_soamer/app_widget/endpoints.dart';
import 'package:app_cashback_soamer/functions/service.dart';

Future<Response> getVaucher() async {
  return await getHTTP(endpoint: Endpoint.endpointVaucher);
}

Future<Response> getDadosRecompensa(String email) async {
  return await getHTTP(
    endpoint: Endpoint.endpointHome,
    parameters: {"email": email},
  );
}