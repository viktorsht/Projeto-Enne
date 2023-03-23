import 'package:http/http.dart' as http;
import '../../api.dart';
import 'dart:convert';
import '../../models/set_date_hour.dart';
import '../models/service.dart';

class RegisterHourController{

  SetDateHour setDateHour = SetDateHour(); // cuida da validação de datas e horas

  Future<List<String>> getTimeActiveApi() async {
    String day = SchedulingApiAppRequest.numeroDiaSemana.toString();
    final response = await http.get(Uri.parse('${DataApi.urlBaseApi}timeActive/$day'));
    
    if (response.statusCode == 200) {
      //_isLoading = false;
      List<dynamic> responseData = jsonDecode(response.body)['data'];
      List<String> timeList = [];

      for (var data in responseData) {
        if(setDateHour.isDateToday(SchedulingApiAppRequest.dateStart)){
          if(setDateHour.isTimeAfterNow(data['time'])){
            timeList.add(data['time']); // faço a validação dos horarios do dia
          }
        }
        else{
          timeList.add(data['time']);
        }
      }
      return timeList;
    } else {
      throw Exception('Requisição falida');
    }
  }

  Future<int> validaSchedule(var start) async {
    String apiUrl = "${DataApi.urlBaseApi}validaSchedule";
    String parametros = 'start=$start';
    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded',},
        body: parametros,
      );
      Map<String, dynamic> dadosApi = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("Requisição bem sucedida: ${response.body}");
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