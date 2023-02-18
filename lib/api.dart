import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> main() async {
  int r = await submitLoginApi();
  print(r);
}

Future<int> submitLoginApi() async {
  const String apiUrl = "http://localhost/phpApi/public_html/api/login";
  var email = "enne@enne.com";
  var password = "123";
  String parametros = 'email=$email&password=$password';
  try {
    http.Response response = await http.post(Uri.parse(apiUrl),
      headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded',},
      body: parametros,);

    if (response.statusCode == 200) {
      return response.statusCode;
      print("Requisição bem sucedida: ${response.body}");
    } else {
      print("Erro na requisição: ${response.statusCode}");
    }
  } catch (e) {
    print("Erro na requisição: $e");
  }
  return 0;
}


