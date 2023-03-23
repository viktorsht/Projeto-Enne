import 'package:http/http.dart' as http;

import '../api.dart';

class ProfileScreenController{
  Future<int> submitUpdateUserApi(var id, var nome, var snome, var email, var cpf, var password, var level, var addr, var social) async {
  String apiUrl = "${DataApi.urlBaseApi}updateUser/";
  String parametros = 'id=$id&name=$nome&surname=$snome&email=$email&cpf=$cpf&password=$password&fk_level=$level&fk_address=$addr&fk_social=$social';
  try {
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded',},
      body: parametros,
    );
    if (response.statusCode == 200) {
      print("Cadastro de usuário bem sucedido: ${response.body}");
      return response.statusCode;
    } else {
      print("Cadastro de usuário não sucedido: ${response.statusCode}");
      return response.statusCode;
    }
  } catch (e) {
    print("Erro no Cadastro de usuário: $e");
  }
  return 0;
}

}