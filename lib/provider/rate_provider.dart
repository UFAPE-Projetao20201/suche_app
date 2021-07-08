// Package imports:
import 'package:http/http.dart';

// Project imports:
import '../http/index.dart';

class RateProvider {

  HttpClient httpClient = HttpAdapter(Client());

  /*

  "user": "60e0b23c049e8d0e37ca06f0",
                "security": 3,
                "quality": 1,
                "faithfulness": 2
              },
      "eventID": "60d47f28d3482301515c8075"

   */

  Future getRatingEvent(String eventId) async {
    try {
      final queryParameters = {
        'eventID': eventId,
      };

      final httpResponse = await httpClient.request(
        url: '/rate',
        method: 'get',
        queryParams: queryParameters,
      );

      return httpResponse;
    } catch (error) {
      print("getRate error - " + error.toString());
      throw error;
    }
  }

  Future confirmPresence(String eventId, String email, String token) async {
    try {
      final body = {
        'email': email,
        'eventID': eventId,
      };

      Map headers = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer '+token,
      };

      final httpResponse = await httpClient.request(
        url: '/confirm',
        method: 'post',
        body: body,
        headers: headers,
      );

      return httpResponse;
    } catch (error) {
      print("getEvents error - " + error.toString());
      throw error;
    }
  }

}
