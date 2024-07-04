import 'package:app_cashback_soamer/app_widget/app_endpoints.dart';
import 'package:app_cashback_soamer/functions/api_connection.dart';
import 'package:app_cashback_soamer/models/venda_model.dart';

Future<Response> registrarVenda(VendaModel vendaModel) async {
  return await postHTTP(
    endpoint: AppEndpoints.endpointVenda,
    body: vendaModel.toMap(),
  );
}
