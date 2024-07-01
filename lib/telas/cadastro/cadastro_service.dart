import 'package:app_cashback_soamer/app_widget/endpoints.dart';
import 'package:app_cashback_soamer/functions/service.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';

Future<Response> postUser(UsuarioModel clienteModel) async {

  print(clienteModel.toMap());

  return await postHTTP(
    endpoint: Endpoint.endpointEntrarCadastrar,
    body: clienteModel.toMap(),
  );
}
