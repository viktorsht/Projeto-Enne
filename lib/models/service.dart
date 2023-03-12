import 'dart:convert';

import 'package:flutter/material.dart';

import '../ip_api.dart';
import 'package:http/http.dart' as http;
class SchedulingApiAppRequest{
  static String idfkService = '';
  static String namefkService = '';
  static String durationfkService = '';
  static String dateStart = '';
  static String dateEnd = '';
  static int numeroDiaSemana = 0; // relaciona os dias da semana como inteiros
  static String hourStart = '';
  static String hourEnd = '';
  static String dateScheduling = '';
  static String precoService = '';
  static String dataEmPtBr = '';
  //String fkClient = '';
  //String fkEmployee = '';
  //String fkCity = '';

  String contatenaData(String hora){
    dateScheduling =  '$dateStart $hora';
    return dateScheduling;
    // concatena data e hora para enviar pra api
  }

  String somarHoras(String hora1, String hora2) {
    // converter as strings para objetos TimeOfDay
    TimeOfDay t1 = TimeOfDay(
        hour: int.parse(hora1.split(":")[0]),
        minute: int.parse(hora1.split(":")[1]));
    TimeOfDay t2 = TimeOfDay(
        hour: int.parse(hora2.split(":")[0]),
        minute: int.parse(hora2.split(":")[1]));
    
    // somar as horas
    int minutos = t1.minute + t2.minute;
    int horas = t1.hour + t2.hour + (minutos ~/ 60);
    minutos = minutos % 60;
    
    // formatar a hora no formato HH:mm:ss
    String h = horas.toString().padLeft(2, '0');
    String m = minutos.toString().padLeft(2, '0');
    return "$h:$m:00";
  }


  void getPrecoServiceApi(String idservice) async {
      var url = Uri.parse('${DataApi.urlBaseApi}price/$idservice');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        //print('Dados do usuário: ${jsonResponse['data']}');
        precoService = jsonResponse['data']['price'];
      } else {
        //print('Erro ao fazer a requisição. Código de status: ${response.statusCode}');
      }
  }
    
}


