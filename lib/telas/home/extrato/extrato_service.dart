import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';

Future<Response> getExtrato(int idVendedor) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointExtrato,
    parameters: {
      "id_usuario": idVendedor.toString(),
    },
  );
}
