import 'package:http/http.dart' as http;
import '../../api.dart';

class RegisterScheduleController{
  Future<int> submitSchedulingAPI(var start, var end, var service, var client, var employee, var city) async {
    String apiUrl = "${DataApi.urlBaseApi}scheduling";
    String parametros = 'start=$start&end=$end&fk_service=$service&fk_client=$client&fk_employee=$employee&fk_city=$city';
    int retorno = 0;
    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded'},
        body: parametros,
      );
      if (response.statusCode == 200) {
        print("AGENDAMENTO bem sucedida: ${response.body}");
        retorno = response.statusCode;
      } else {
        print("AGENDAMENTO não sucedida: ${response.statusCode}");
        retorno = response.statusCode;
      }
    } catch (e) {
      print("Erro na requisição: $e");
    }
    return retorno;
  }
}