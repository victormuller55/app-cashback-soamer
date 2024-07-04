import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/app_widget/consts/app_endpoints.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';

Future<Response> postUser(VendedorModel clienteModel) async {
  return await postHTTP(
    endpoint: AppEndpoints.endpointEntrarCadastrar,
    body: clienteModel.toMap(),
  );
}
