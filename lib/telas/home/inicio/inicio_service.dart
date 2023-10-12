import 'package:app_cashback_soamer/app_widget/endpoints.dart';
import 'package:app_cashback_soamer/functions/local_data.dart';
import 'package:app_cashback_soamer/functions/service.dart';
import 'package:app_cashback_soamer/models/usuario_model.dart';

Future<Response> getHome(String email) async {
  return await getHTTP(
    endpoint: Endpoint.endpointHome,
    parameters: {"email": email},
  );
}

Future<Response> getVaucherPromocao() async {
  return await getHTTP(endpoint: Endpoint.endpointVaucherPromocao);
}

Future<Response> getVaucherMaisTrocados() async {
  return await getHTTP(endpoint: Endpoint.endpointVaucherMaisTrocados);
}

Future<Response> getConcessionarias() async {
  return await getHTTP(endpoint: Endpoint.endpointConcessionaria);
}

Future<Response> setConcessionaria(int idConcessionaria) async {
  UsuarioModel usuarioModel = await getModelLocal();
  return await putHTTP(
    endpoint: Endpoint.endpointConcessionaria,
    parameters: {
      "id_concessionaria": idConcessionaria.toString(),
      "id_usuario": usuarioModel.idUsuario.toString(),
    }
  );
}
