import 'dart:convert';
import 'dart:io';

import 'package:app_cashback_soamer/app_widget/api_exception.dart';
import 'package:app_cashback_soamer/functions/internet_connection.dart';
import 'package:flutter/foundation.dart';
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

Future<Response> postHTTP({
  required String endpoint,
  required Map<String, dynamic> body,
  Map<String, String>? parameters,
  File? file,
}) async {

  if (kDebugMode) {
    print("API: $endpoint${getParametersFormatted(parameters: parameters)}");
  }

  if (await thereInternetConnection()) {

    http.Response endpointResult = http.Response("", 500);

    var request = http.MultipartRequest('POST', Uri.parse(endpoint + getParametersFormatted(parameters: parameters)));
    request.fields.addAll(body.map((key, value) => MapEntry(key, value.toString())));

    if (file != null) {
      request.files.add(
        http.MultipartFile(
          'file',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last
        ),
      );

      var streamedResponse = await request.send();
      endpointResult = await http.Response.fromStream(streamedResponse);
    }

    if(file == null) {
      endpointResult = await http.post(Uri.parse(endpoint + getParametersFormatted(parameters: parameters)), headers: header, body: jsonEncode(body));
    }

    if (endpointResult.statusCode == 200) {
      return Response(statusCode: endpointResult.statusCode, body: endpointResult.body);
    }
    throw ApiException(Response(statusCode: endpointResult.statusCode, body: endpointResult.body));
  }
  throw ApiException(Response(statusCode: 502, body: noInternetConnectionError()));
}


Future<Response> putHTTP({required String endpoint, Map<String, String>? parameters, Map<String, dynamic>? body}) async {

  if (kDebugMode) {
    print("API: $endpoint${getParametersFormatted(parameters: parameters)}");
  }

  if (kDebugMode) {
    print("API SEND: ${body}");
  }

  if (await thereInternetConnection()) {
    http.Response endpointResult = await http.put(Uri.parse(endpoint + getParametersFormatted(parameters: parameters)), headers: header, body: jsonEncode(body));
    if (endpointResult.statusCode == 200) {
      return Response(statusCode: endpointResult.statusCode, body: endpointResult.body);
    }
    throw ApiException(Response(statusCode: endpointResult.statusCode, body: endpointResult.body));
  }
  throw ApiException(Response(statusCode: 502, body: noInternetConnectionError()));
}

Future<Response> getHTTP({required String endpoint, Map<String, String>? parameters}) async {

  if (kDebugMode) {
    print("API: $endpoint${getParametersFormatted(parameters: parameters)}");
  }

  if (await thereInternetConnection()) {
    http.Response endpointResult = await http.get(Uri.parse(endpoint + getParametersFormatted(parameters: parameters)), headers: header);
    if (endpointResult.statusCode == 200) {
      return Response(statusCode: endpointResult.statusCode, body: endpointResult.body);
    }
    throw ApiException(Response(statusCode: endpointResult.statusCode, body: endpointResult.body));
  }
  throw ApiException(Response(statusCode: 502, body: noInternetConnectionError()));
}

class Response {
  int statusCode;
  String body;

  Response({required this.statusCode, required this.body});
}
