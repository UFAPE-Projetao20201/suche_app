import 'dart:convert';

import 'package:http/http.dart';
import 'package:suche_app/model/user.dart';
import 'package:suche_app/services/storage.dart';

import '../http/index.dart';

class UserProvider {

  HttpClient httpClient = HttpAdapter(Client());

  Future createUser({required String name, required String surname, required String email, required String phone, required String gender, required String birthDate, required String password}) async {
    try {
      Map body = {
        "name": name,
        "surname": surname,
        "email": email,
        "phone": phone,
        "gender": gender,
        "birthDate": birthDate,
        "password": password,
      };

      final httpResponse = await httpClient.request(
        url: '/auth/register/',
        method: 'post',
        body: body,
      );

      // Transformando os dados em um User e codificando para Json personalizado
      User user = User.fromJson(httpResponse);
      String userJson = jsonEncode(user);

      //Guardando o usuário de forma segura localmente
      final SecureStorage secureStorage = SecureStorage();
      await secureStorage.writeSecureData('user', userJson);

      return httpResponse;
    } catch (error) {
      print("createUser error - " + error.toString());
      throw error;
    }
  }


  Future userLogin({String? email, String? password}) async {
    try {
      Map body = {
        "email": email,
        "password": password,
      };

      final httpResponse = await httpClient.request(
        url: '/auth/authenticate/',
        method: 'post',
        body: body,
      );

      // Transformando os dados em um User e codificando para Json personalizado
      User user = User.fromJson(httpResponse);
      String userJson = jsonEncode(user);

      //Guardando o usuário de forma segura localmente
      final SecureStorage secureStorage = SecureStorage();
      await secureStorage.writeSecureData('user', userJson);

      return httpResponse;
    } catch (error) {
      print("getUser error - " + error.toString());
      throw error;
    }
  }

  Future setPromoterUser({String? email, String? cpfCnpj, String? token}) async {
    try {
      Map body = {
        "email": email,
        "CPF_CNPJ": cpfCnpj,
      };

      Map headers = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer '+token!,
      };

      final httpResponse = await httpClient.request(
        url: '/auth/promote/',
        method: 'put',
        body: body,
        headers: headers,
      );

      return httpResponse;
    } catch (error) {
      print("setPromoterUser error - " + error.toString());
      throw error;
    }
  }


}