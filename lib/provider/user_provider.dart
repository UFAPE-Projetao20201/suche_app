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

      late final httpResponse = httpClient.request(
        url: '/auth/register/',
        method: 'post',
        body: body,
      );

      return httpResponse;
    } catch (error) {
      print("createUser error - " + error.toString());
      throw error;
    }
  }


  Future getUser({String? email, String? password}) async {
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

      //Lendo o usuário de forma segura localmente
      String? value = await secureStorage.readSecureData('user');
      print(value);

      return httpResponse;
    } catch (error) {
      print("getUser error - " + error.toString());
      throw error;
    }
  }

  Future setPromoterUser({String? email, String? cpfCnpj}) async {
    try {
      Map body = {
        "email": email,
        "CPF_CNPJ": cpfCnpj,
      };

      final httpResponse = await httpClient.request(
        url: '/auth/promote/',
        method: 'post',
        body: body,
      );

      return httpResponse;
    } catch (error) {
      print("setPromoterUser error - " + error.toString());
      throw error;
    }
  }


}