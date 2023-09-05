import 'package:app_cashback_soamer/functions/service.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';

Future<Response> postUser(UsuarioModel clienteModel) async {
  return await postHTTP(endpoint: "http://172.20.10.8:8080/v1/soamer/usuario", body: clienteModel.toMap());
}