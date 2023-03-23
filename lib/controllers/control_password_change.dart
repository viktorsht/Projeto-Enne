import '../api.dart';
import 'package:http/http.dart' as http;

class PasswordChangeController{
  Future<int> trocarSenhaAPI(var id, var password) async {
    String apiUrl = "${DataApi.urlBaseApi}password";
    String parametros = 'id=$id&password=$password';
    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded',},
        body: parametros,
      );
      if (response.statusCode == 200) {
        print("Atualização de senha bem sucedida: ${response.body}");
        return response.statusCode;
      } else {
        print("Atualização de senha não sucedida: ${response.statusCode}");
        return response.statusCode;
      }
    } catch (e) {
      print("Erro na atualização de senha: $e");
    }
    return 0;
  }
}