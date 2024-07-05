import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:muller_package/muller_package.dart';

Future<AppResponse> postUser(VendedorModel clienteModel) async {
  return await postHTTP(
    endpoint: AppEndpoints.endpointEntrarCadastrar,
    body: clienteModel.toMap(),
  );
}
