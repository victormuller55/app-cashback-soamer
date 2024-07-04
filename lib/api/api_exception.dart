import 'dart:convert';

import 'package:app_cashback_soamer/api/api_connection.dart';
import 'package:app_cashback_soamer/models/error_model.dart';

class ApiException implements Exception {
  final Response response;

  ApiException(this.response);

  @override
  String toString() {
    return 'ApiException: ${response.statusCode} ${response.body}';
  }

  static ErrorModel errorModel(Object e) {
    if(e is ApiException) {
      return ErrorModel.fromMap(jsonDecode(e.response.body));
    }

    return ErrorModel.empty();
  }
}