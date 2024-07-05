
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';
import 'package:muller_package/muller_package.dart';

Future<AppResponse> getCodeVoucher(int idVoucher, int idVendedor) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointTrocarVoucher,
    parameters: {
      "id_vaucher" : idVoucher.toString(),
      "id_usuario" : idVendedor.toString(),
    }
  );
}