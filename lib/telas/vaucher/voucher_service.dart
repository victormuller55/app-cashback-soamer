
import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';

Future<Response> getCodeVoucher(int idVoucher, int idVendedor) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointTrocarVoucher,
    parameters: {
      "id_vaucher" : idVoucher.toString(),
      "id_usuario" : idVendedor.toString(),
    }
  );
}