import 'dart:convert';
import 'package:enne_barbearia/api.dart';
import 'package:enne_barbearia/models/schedule_client.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/userActive.dart';

class CheduleUserController{
  List<dynamic> _dados = [];

  static Future<String> _carregarDados(String idService) async {
    var url = Uri.parse('${DataApi.urlBaseApi}service/$idService');
    var response = await http.get(url);
    var dados = jsonDecode(response.body);
    return dados['data']['name'];
  }

  static Future<List<AgendamentosCliente>> getAgendamentos() async {
    String id = UserActiveApp.idUser;
    var url = '${DataApi.urlBaseApi}scheduling/$id';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      if (jsonResponse.isNotEmpty) {
        dynamic decoded = jsonDecode(jsonResponse);
        decoded = decoded['data'];
        final dateFormat = DateFormat('dd/MM/yyyy');
        if (decoded is List) {
          return Future.wait(decoded.map((agendamento) async => AgendamentosCliente(
            nome: agendamento['name'],
            servico: await _carregarDados(agendamento['fk_service'].toString()),
            horario: (String dataHora) {
              List<String> partes = dataHora.split(' ');
              String hora = partes[1];
              return hora;
            }(agendamento['start']),
            dia: dateFormat.format(DateTime.parse(agendamento['start'].toString().split(" ")[0])),
            preco: await (String idService) async {
              var url = Uri.parse('${DataApi.urlBaseApi}price/$idService');
              var response = await http.get(url);
              if (response.statusCode == 200) {
                var dados = jsonDecode(response.body);
                return dados['data']['price'];
            }
          }(agendamento['fk_service'].toString()),
          idAgendamento: agendamento['scheduling_id'],
          )).toList());
        } else if (decoded is Map<String, dynamic>) {
          return [AgendamentosCliente(
            nome: decoded['name'],
            servico: await _carregarDados(decoded['fk_service'].toString()),
            horario: (String dataHora) {
              List<String> partes = dataHora.split(' ');
              String hora = partes[1];
              return hora;
            }(decoded['start']),
            dia: dateFormat.format(DateTime.parse(decoded['start'].toString().split(" ")[0])),
            preco: await (String idService) async {
              var url = Uri.parse('${DataApi.urlBaseApi}price/$idService');
              var response = await http.get(url);
              if (response.statusCode == 200) {
                var dados = jsonDecode(response.body);
                return dados['data']['price'];
            }
          }(decoded['fk_service'].toString()),
          idAgendamento: decoded['scheduling_id'],
          )];
        } else {
          throw Exception('Resposta inválida da API');
        }
      } else {
        throw Exception('Corpo da resposta é nulo ou vazio');
      }
    } else {
      throw Exception('Falha ao carregar agendamentos');
    }
  }

  Future<int> submitDeleteSchedule(String idSchedule) async {
    String apiUrl = "${DataApi.urlBaseApi}deleteScheduling";
    String parametros = 'scheduling_id=$idSchedule';
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