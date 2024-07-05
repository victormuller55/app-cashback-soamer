import 'dart:io';
import 'package:muller_package/muller_package.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';
import 'package:app_cashback_soamer/models/edit_vendedor_model.dart';

Future<AppResponse> editarVendedor(EditVendedorModel clienteModel) async {
  return await putHTTP(
    endpoint: AppEndpoints.endpointEditarVendedor,
    body: clienteModel.toMap(),
  );
}

Future<AppResponse> editarFotoVendedor(int idVendedor, File file) async {
  return await postHTTP(
    endpoint: AppEndpoints.endpointImageVendedor(idVendedor),
    body: {},
    file: file,
  );
}
