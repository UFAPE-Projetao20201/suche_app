import 'package:http/http.dart';

import '../http/index.dart';

class UserProvider {

  HttpClient httpClient = HttpAdapter(Client());

  Future createUser({String nome, String sobrenome, String email, String telefone, String genero, String dataNascimento, String password}) async {
    try {
      Map body = {
        "nome": nome,
        "sobrenome": sobrenome,
        "email": email,
        "telefone": telefone,
        "genero": genero,
        "dataNascimento": dataNascimento,
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

}