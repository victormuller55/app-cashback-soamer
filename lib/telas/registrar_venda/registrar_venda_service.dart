import 'package:app_cashback_soamer/app_widget/endpoints.dart';
import 'package:app_cashback_soamer/functions/service.dart';
import 'package:app_cashback_soamer/models/venda_model.dart';

Future<Response> registrarVenda(VendaModel vendaModel, String ponteira) async {
  return await postHTTP(
    endpoint: Endpoint.endpointVenda,
    body: vendaModel.toMap(),
    parameters: {"ponteira": ponteira},
  );
}
