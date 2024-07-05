import 'package:muller_package/muller_package.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';

Future<AppResponse> getHome(String email) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointHome,
    parameters: {"email": email},
  );
}

Future<AppResponse> getVaucherPromocao() async {
  return await getHTTP(endpoint: AppEndpoints.endpointVaucherPromocao);
}

Future<AppResponse> getVaucherMaisTrocados() async {
  return await getHTTP(endpoint: AppEndpoints.endpointVaucherMaisTrocados);
}

Future<AppResponse> getConcessionarias() async {
  return await getHTTP(endpoint: AppEndpoints.endpointConcessionaria);
}

Future<AppResponse> setConcessionaria(int idConcessionaria) async {
  VendedorModel vendedorModel = await getModelLocal();
  return await putHTTP(
    endpoint: AppEndpoints.endpointConcessionaria,
    parameters: {
      "id_concessionaria": idConcessionaria.toString(),
      "id_usuario": vendedorModel.id.toString(),
    }
  );
}
