import 'dart:convert';

import 'package:http/http.dart';
import 'package:suche_app/model/event.dart';
import 'package:suche_app/model/user.dart';
import 'package:suche_app/services/storage.dart';

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
}