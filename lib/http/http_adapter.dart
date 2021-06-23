// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:http/http.dart';

// Project imports:
import 'package:suche_app/app_configuration.dart';
import './http_client.dart';
import './http_error.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<dynamic> request({String? url, String? method, File? image, Map? body, Map? headers, var queryParams}) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}..addAll({'content-type': 'application/json', 'accept': 'application/json'});
    final jsonBody = body != null ? jsonEncode(body) : null;
    var response = Response('', 500);
    Uri uri = new Uri.http(AppConfiguration.apiBaseUrl, url!, queryParams);
    Future<Response> futureResponse = Future<Response>.value(response);
    try {
      if (method == 'post') {
        futureResponse = client.post(
          uri,
          headers: defaultHeaders,
          body: jsonBody,
        );
      } else if (method == 'get') {
        futureResponse = client.get(
          uri,
          headers: defaultHeaders,
        );
      } else if (method == 'put') {
        futureResponse = client.put(
          uri,
          headers: defaultHeaders,
          body: jsonBody,
        );
      } else if (method == 'patch') {
        futureResponse = client.patch(
          uri,
          headers: defaultHeaders,
          body: jsonBody,
        );
      }
      response = await futureResponse.timeout(Duration(seconds: 20));
    } catch (error) {
      print('http -> ' + error.toString());
      throw HttpError.serverError;
    }
    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty ? null : jsonDecode(response.body);
      case 201:
        return response.body.isEmpty ? null : jsonDecode(response.body);
      case 204:
        return null;
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      default:
        throw HttpError.serverError;
    }
  }
}
