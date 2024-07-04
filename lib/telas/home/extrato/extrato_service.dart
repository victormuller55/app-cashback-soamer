import 'package:app_cashback_soamer/app_widget/app_endpoints.dart';
import 'package:app_cashback_soamer/functions/api_connection.dart';

Future<Response> getExtrato(int idUsuario) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointExtrato,
    parameters: {
      "id_usuario": idUsuario.toString(),
    },
  );
}
