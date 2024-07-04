import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/models/vendedor_model.dart';

Future<Response> getHome(String email) async {
  return await getHTTP(
    endpoint: AppEndpoints.endpointHome,
    parameters: {"email": email},
  );
}

Future<Response> getVaucherPromocao() async {
  return await getHTTP(endpoint: AppEndpoints.endpointVaucherPromocao);
}

Future<Response> getVaucherMaisTrocados() async {
  return await getHTTP(endpoint: AppEndpoints.endpointVaucherMaisTrocados);
}

Future<Response> getConcessionarias() async {
  return await getHTTP(endpoint: AppEndpoints.endpointConcessionaria);
}

Future<Response> setConcessionaria(int idConcessionaria) async {
  VendedorModel vendedorModel = await getModelLocal();
  return await putHTTP(
    endpoint: AppEndpoints.endpointConcessionaria,
    parameters: {
      "id_concessionaria": idConcessionaria.toString(),
      "id_usuario": vendedorModel.id.toString(),
    }
  );
}
