import 'dart:io';

import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';
import 'package:app_cashback_soamer/models/edit_vendedor_model.dart';

Future<Response> editarVendedor(EditVendedorModel clienteModel) async {
  return await putHTTP(
    endpoint: AppEndpoints.endpointEditarVendedor,
    body: clienteModel.toMap(),
  );
}

Future<Response> editarFotoVendedor(int idVendedor, File file) async {
  return await postHTTP(
    endpoint: AppEndpoints.endpointImageVendedor(idVendedor),
    body: {},
    file: file,
  );
}
