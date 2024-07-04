import 'package:app_cashback_soamer/app_widget/app_endpoints.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/api_connection.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';

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
  VendedorModel usuarioModel = await getModelLocal();
  return await putHTTP(
    endpoint: AppEndpoints.endpointConcessionaria,
    parameters: {
      "id_concessionaria": idConcessionaria.toString(),
      "id_usuario": usuarioModel.id.toString(),
    }
  );
}
