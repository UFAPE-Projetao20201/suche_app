// Package imports:
import 'package:http/http.dart';

// Project imports:
import '../http/index.dart';

class EventProvider {

  HttpClient httpClient = HttpAdapter(Client());

  Future createEvent({required String token,required String promoter, required String name, required String description, required String category, required double value, required String date, required List<String> keywords, required Map localization, required String link, required bool isOnline, required bool isLocal}) async {
    try {
      Map body = {
        "promoter": promoter,
        "name": name,
        "description": description,
        "category": category,
        "value": value,
        "date": date,
        "keywords": keywords,
        "localization": localization,
        "link": link,
        "isOnline": isOnline,
        "isLocal": isLocal
      };

      Map headers = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer '+token,
      };

      final httpResponse = await httpClient.request(
        url: '/event/',
        method: 'post',
        body: body,
        headers: headers,
      );

      return httpResponse;
    } catch (error) {
      print("createEvent error - " + error.toString());
      throw error;
    }
  }

  Future createEventOnline({required String token,required String promoter, required String name, required String description, required String category, required double value, required String date, required List<String> keywords, required String link, required bool isOnline, required bool isLocal}) async {
    try {
      Map body = {
        "promoter": promoter,
        "name": name,
        "description": description,
        "category": category,
        "value": value,
        "date": date,
        "keywords": keywords,
        "link": link,
        "isOnline": isOnline,
        "isLocal": isLocal
      };

      Map headers = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer '+token,
      };

      final httpResponse = await httpClient.request(
        url: '/event/',
        method: 'post',
        body: body,
        headers: headers,
      );

      return httpResponse;
    } catch (error) {
      print("createEvent error - " + error.toString());
      throw error;
    }
  }

  Future listEvents({String? email, String? password}) async {
    try {
      final httpResponse = await httpClient.request(
        url: '/event',
        method: 'get',
      );

      return httpResponse;
    } catch (error) {
      print("getEvents error - " + error.toString());
      throw error;
    }
  }
  Future listPresentialEvents(String? name, String? category, String email) async {
    try {
      final queryParameters = {
        'name': name,
        'category': category,
        'email': email,
      };

      final httpResponse = await httpClient.request(
        url: '/eventpresential',
        method: 'get',
        queryParams: queryParameters,
      );


      return httpResponse;
    } catch (error) {
      print("getEvents error - " + error.toString());
      throw error;
    }
  }

  Future listOnlineEvents(String? name, String? category, String email) async {
    try {
      final queryParameters = {
        'name': name,
        'category': category,
        'email': email,
      };

      final httpResponse = await httpClient.request(
        url: '/eventonline',
        method: 'get',
        queryParams: queryParameters,
      );

      return httpResponse;
    } catch (error) {
      print("getEvents error - " + error.toString());
      throw error;
    }
  }
  Future listConfirmedEvents(String? email) async {
    try {
      final queryParameters = {
        'email': email,
      };

      final httpResponse = await httpClient.request(
        url: '/confirmedevents',
        method: 'get',
        queryParams: queryParameters,
      );

      return httpResponse;
    } catch (error) {
      print("getEvents error - " + error.toString());
      throw error;
    }
  }
  Future listPastEvents(String? email) async {
    try {
      final queryParameters = {
        'email': email,
      };

      final httpResponse = await httpClient.request(
        url: '/pastevents',
        method: 'get',
        queryParams: queryParameters,
      );

      return httpResponse;
    } catch (error) {
      print("getEvents error - " + error.toString());
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

  Future unconfirmPresence(String eventId, String email, String token) async {
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
        url: '/unconfirm',
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
