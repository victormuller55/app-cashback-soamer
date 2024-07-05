import 'package:muller_package/muller_package.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';

Future<AppResponse> getExtrato(int idVendedor) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointExtrato,
    parameters: {
      "id_usuario": idVendedor.toString(),
    },
  );
}
