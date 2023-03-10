import 'package:http/http.dart' as http;
import '../ip_api.dart';
import 'dart:convert';

class ContatoApp {

  static String email = '';
  static String telefone = '';

  void getContatoApp() async {
      String myIp = IpApi.myIp;
      var url = Uri.parse('http://$myIp/phpApi/public_html/api/contato');
      var response = await http.get(url);

      try {
        if (response.statusCode == 200) {
          //print("Estou fazendo get do contato");
          var jsonResponse = jsonDecode(response.body);
          print('Dados do usuário: ${jsonResponse['data']}');
          email = jsonResponse['data']['email'];
          telefone = jsonResponse['data']['phone'];
        } else {
          print('Erro ao fazer a requisição. Código de status: ${response.statusCode}');
        }
        
      } catch (e) {
        print("Erro na requisição: $e");
      }

  }
}

