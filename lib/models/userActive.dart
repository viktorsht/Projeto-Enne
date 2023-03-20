import 'package:http/http.dart' as http;
import '../api.dart';
import 'dart:convert';

class UserActiveApp {

  static String idUser = '';
  static String nameUser = '';
  static String sobrenameUser = '';
  static String cpfUser = '';
  static String emailUser = '';
  static String senhaUser = '';

  void idUserActive(String id) {
    idUser = id;
    getUser();
  }
  void getUser() async {
      var url = Uri.parse('${DataApi.urlBaseApi}user/$idUser');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        nameUser = jsonResponse['data']['name'];
        sobrenameUser = jsonResponse['data']['surname'];
        emailUser = jsonResponse['data']['email'];
        cpfUser = jsonResponse['data']['cpf'];
        senhaUser = jsonResponse['data']['password'];
      } else {
        print('Erro ao fazer a requisição. Código de status: ${response.statusCode}');
      }
  }
}

