import 'package:muller_package/muller_package.dart';
import 'package:app_cashback_soamer/app_widget/app_consts/app_endpoints.dart';
import 'package:app_cashback_soamer/models/venda_model.dart';

Future<AppResponse> registrarVenda(VendaModel vendaModel) async {
  return await postHTTP(
    endpoint: AppEndpoints.endpointVenda,
    body: vendaModel.toMap(),
  );
}
