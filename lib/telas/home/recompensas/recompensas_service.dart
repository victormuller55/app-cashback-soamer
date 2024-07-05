import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';
import 'package:muller_package/muller_package.dart';

Future<AppResponse> getVaucher() async {
  return await getHTTP(endpoint: AppEndpoints.endpointVoucher);
}

Future<AppResponse> getDadosRecompensa(String email) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointHome,
    parameters: {"email": email},
  );
}