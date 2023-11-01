import 'package:app_cashback_soamer/app_widget/endpoints.dart';
import 'package:app_cashback_soamer/functions/service.dart';

Future<Response> getPDF() async {
  return await getHTTP(endpoint: Endpoint.endpointLoadPDF);
}
