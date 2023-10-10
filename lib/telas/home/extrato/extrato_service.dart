import 'package:app_cashback_soamer/app_widget/endpoints.dart';
import 'package:app_cashback_soamer/functions/service.dart';

Future<Response> getExtrato(int idUsuario) async {
  return await getHTTP(
    endpoint: Endpoint.endpointExtrato,
    parameters: {
      "id_usuario": idUsuario.toString(),
    },
  );
}
