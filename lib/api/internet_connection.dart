import 'package:connectivity/connectivity.dart';

Future<bool> thereInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}

String noInternetConnectionError() {
  return '{"tipo":"BAD GATEWAY","mensagem":"Verifique sua conexão com a internet","erro":" Sem conexão com a internet"}';
}