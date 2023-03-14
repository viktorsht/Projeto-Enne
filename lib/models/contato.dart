import 'package:http/http.dart' as http;
import '../api.dart';
import 'dart:convert';

class ContatoApp {

  static String email = '';
  static String telefone = '';

  void getContatoApp() async {
      var url = Uri.parse('${DataApi.urlBaseApi}contato');
      var response = await http.get(url);

      try {
        if (response.statusCode == 200) {
          //print("Estou fazendo get do contato");
          var jsonResponse = jsonDecode(response.body);
          //('Dados do usuário: ${jsonResponse['data']}');
          email = jsonResponse['data']['email'];
          telefone = jsonResponse['data']['phone'];
        } else {
          //print('Erro ao fazer a requisição. Código de status: ${response.statusCode}');
        }
        
      } catch (e) {
        //print("Erro na requisição: $e");
      }

  }
}

