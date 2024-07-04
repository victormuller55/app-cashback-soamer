import 'dart:io';

import 'package:app_cashback_soamer/app_widget/app_endpoints.dart';
import 'package:app_cashback_soamer/functions/api_connection.dart';
import 'package:app_cashback_soamer/models/edit_usuario_model.dart';

Future<Response> editarUsuario(EditUsuarioModel clienteModel) async {
  return await putHTTP(
    endpoint: AppEndpoints.endpointEditarUsuario,
    body: clienteModel.toMap(),
  );
}

Future<Response> editarFotoUsuario(int idUsuario, File file) async {
  return await postHTTP(
    endpoint: AppEndpoints.endpointImageUsuario(idUsuario),
    body: {},
    file: file,
  );
}
