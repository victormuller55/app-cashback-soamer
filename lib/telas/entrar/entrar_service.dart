import 'package:app_cashback_soamer/functions/service.dart';

Future<Response> getUser(String email, String senha) async {
  return await getHTTP(
    endpoint: "192.168.0.188:8080/v1/soamer/usuario",
    parameters: {
      "email": email,
      "senha": senha,
    },
  );
}
