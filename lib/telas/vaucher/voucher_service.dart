import 'package:app_cashback_soamer/app_widget/app_endpoints.dart';
import 'package:app_cashback_soamer/functions/api_connection.dart';

Future<Response> getCodeVoucher(int idVoucher, int idUsuario) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointTrocarVoucher,
    parameters: {
      "id_vaucher" : idVoucher.toString(),
      "id_usuario" : idUsuario.toString(),
    }
  );
}