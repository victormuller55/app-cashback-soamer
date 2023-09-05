import 'dart:convert';
import 'package:http/http.dart' as http;

Map<String, String>? header = <String, String>{'Content-Type': 'application/json; charset=UTF-8'};

String getParametersFormatted({required Map<String, dynamic>? parameters}) {
  List<String> list = [];

  if (parameters != null) {
    parameters.forEach((key, value) => list.add("$key=$value"));
    return '?${list.join('&')}';
  }

  return "";
}

Future<Response> postHTTP({required String endpoint, required Map<String, dynamic> body, Map<String, String>? parameters}) async {
  http.Response endpointResult = await http.post(Uri.parse(endpoint + getParametersFormatted(parameters: parameters)), headers: header, body: jsonEncode(body));
  return Response(statusCode: endpointResult.statusCode, body: endpointResult.body);
}

Future<Response> putHTTP({required String endpoint, Map<String, String>? parameters}) async {
  http.Response endpointResult = await http.put(Uri.parse(endpoint + getParametersFormatted(parameters: parameters)), headers: header);
  return Response(statusCode: endpointResult.statusCode, body: endpointResult.body);
}

Future<Response> getHTTP({required String endpoint, Map<String, String>? parameters}) async {
  http.Response endpointResult = await http.get(Uri.parse(endpoint + getParametersFormatted(parameters: parameters)), headers: header);
  return Response(statusCode: endpointResult.statusCode, body: endpointResult.body);
}

class Response {
  int statusCode;
  String body;

  Response({required this.statusCode,required this.body});
}