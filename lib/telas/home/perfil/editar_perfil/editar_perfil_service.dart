import 'dart:io';

import 'package:app_cashback_soamer/app_widget/endpoints.dart';
import 'package:app_cashback_soamer/functions/service.dart';
import 'package:app_cashback_soamer/models/edit_usuario_model.dart';

Future<Response> editarUsuario(EditUsuarioModel clienteModel) async {
  return await putHTTP(
    endpoint: Endpoint.endpointEditarUsuario,
    body: clienteModel.toMap(),
  );
}

Future<Response> editarFotoUsuario(int idUsuario, File file) async {
  return await postHTTP(
    endpoint: Endpoint.endpointImageUsuario(idUsuario),
    body: {},
    file: file,
  );
}
