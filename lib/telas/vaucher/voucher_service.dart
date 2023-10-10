import 'package:app_cashback_soamer/app_widget/endpoints.dart';
import 'package:app_cashback_soamer/functions/service.dart';

Future<Response> getCodeVoucher(int idVoucher, int idUsuario) async {
  return await getHTTP(
    endpoint: Endpoint.endpointTrocarVoucher,
    parameters: {
      "id_vaucher" : idVoucher.toString(),
      "id_usuario" : idUsuario.toString(),
    }
  );
}