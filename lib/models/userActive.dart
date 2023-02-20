import 'package:http/http.dart' as http;
import '../ip_api.dart';
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
      const myIp = IpApi.myIp;
      var url = Uri.parse('http://$myIp/phpApi/public_html/api/user/$idUser');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('Dados do usuário: ${jsonResponse['data']}');
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

