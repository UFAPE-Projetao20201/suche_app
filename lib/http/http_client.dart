import 'dart:io';

abstract class HttpClient {
  Future<dynamic> request({
    String? url,
    String? method,
    File? image,
    Map? body,
    Map? headers,
    var queryParams
  });
}
