import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api.dart';
import '../models/contato.dart';
import '../models/userActive.dart';

class LoginAppController{
  Future<int> submitLoginApi(var email, var password) async {
    String apiUrl = "${DataApi.urlBaseApi}login";
    String parametros = 'email=$email&password=$password';
    UserActiveApp userActive = UserActiveApp();
    ContatoApp contato = ContatoApp();
    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded',},
        body: parametros,
      );
      Map<String, dynamic> dadosApi = jsonDecode(response.body);
      if (response.statusCode == 200) {
        userActive.idUserActive(dadosApi['data']['id']);
        contato.getContatoApp();
        return response.statusCode;
      } else {
        print("Requisição não sucedida: ${response.statusCode}");
        return response.statusCode;
      }
    } catch (e) {
      print("Erro na requisição: $e");
    }
    return 0;
  }
}