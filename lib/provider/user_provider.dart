import 'package:http/http.dart';

import '../http/index.dart';

class UserProvider {

  HttpClient httpClient = HttpAdapter(Client());

  Future createUser({String? nome, String? sobrenome, String? email, String? telefone, String? genero, String? dataNascimento, String? password}) async {
    try {
      Map body = {
        "name": nome,
        "surname": sobrenome,
        "email": email,
        "phone": telefone,
        "gender": genero,
        "birthDate": dataNascimento,
        "password": password,
      };

      // var data = UserSimplePreferences.getLogin();
      final httpResponse = await httpClient.request(
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

      // var data = UserSimplePreferences.getLogin();
      final httpResponse = await httpClient.request(
        url: '/auth/authenticate/',
        method: 'post',
        body: body,
      );

      return httpResponse;
    } catch (error) {
      print("getUser error - " + error.toString());
      throw error;
    }
  }


}