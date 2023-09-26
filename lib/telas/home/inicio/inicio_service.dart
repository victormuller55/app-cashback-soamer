import 'package:app_cashback_soamer/app_widget/endpoints.dart';
import 'package:app_cashback_soamer/functions/service.dart';

Future<Response> getHome(String email) async {
  return await getHTTP(
    endpoint: Endpoint.endpointHome,
    parameters: {"email": email},
  );
}

Future<Response> getVaucherPromocao() async {
  return await getHTTP(endpoint: Endpoint.endpointVaucherPromocao);
}

Future<Response> getVaucherMaisTrocados() async {
  return await getHTTP(endpoint: Endpoint.endpointVaucherMaisTrocados);
}
