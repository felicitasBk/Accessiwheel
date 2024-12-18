import 'dart:convert';

import 'package:http/http.dart';
import 'package:wheelmap/common/manager/networking/nothing.dart';
import 'package:wheelmap/common/manager/networking/request_type.dart';
import 'package:wheelmap/common/manager/networking/request_type_exception.dart';

class NetworkClient {
  //Base url
  static const String _baseUrl = "http://127.0.0.1:8888";
  final Client _client;

  NetworkClient(this._client);

  Future<Response> request(
      {required RequestType requestType,
      required String path,
      dynamic parameter = Nothing}) async {
    Uri uri = apiUri(path);
    switch (requestType) {
      case RequestType.GET:
        return _client.get(uri);
      case RequestType.POST:
        return _client.post(
          uri,
          headers: {"Content-Type": "application/json"},
          body: json.encode(parameter),
        );
      case RequestType.DELETE:
        return _client.delete(uri);
      default:
        return throw RequestTypeNotFoundException(
            "The HTTP request mentioned is not found");
    }
  }

  Uri apiUri(String endpoint) {
    String apiPath = "$_baseUrl/$endpoint";
    return Uri.parse(apiPath);
  }
}
