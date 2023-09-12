import 'package:app_cashback_soamer/functions/service.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';

Future<Response> postUser(UsuarioModel clienteModel) async {
  return await postHTTP(endpoint: "http://192.168.0.188:8080/v1/soamer/usuario", body: clienteModel.toMap());
}