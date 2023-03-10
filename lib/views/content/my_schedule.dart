import 'dart:convert';
import 'package:enne_barbearia/views/content/deleted_completed.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../ip_api.dart';
import '../../models/service.dart';
import '../../models/userActive.dart';

class Agendamento {
  String nome;
  String servico;
  String horario;
  String dia;
  String preco;
  String idAgendamento;

  Agendamento({
    required this.nome, 
    required this.servico, 
    required this.dia, 
    required this.horario, 
    required this.preco,
    required this.idAgendamento
    });
}

class ApiService {
  List<dynamic> _dados = [];

  static Future<String> _carregarDados(String idService) async {
    String myIp = IpApi.myIp;
    var url = Uri.parse('http://$myIp/phpApi/public_html/api/service/$idService');
    var response = await http.get(url);
    var dados = jsonDecode(response.body);
    return dados['data']['name'];
  }

  static Future<List<Agendamento>> getAgendamentos() async {
    String myIp = IpApi.myIp;
    String id = UserActiveApp.idUser;
    SchedulingApiAppRequest serviceApi = SchedulingApiAppRequest();

    var url = 'http://$myIp/phpApi/public_html/api/scheduling/$id';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      if (jsonResponse != null && jsonResponse.isNotEmpty) {
        dynamic decoded = jsonDecode(jsonResponse);
        decoded = decoded['data'];
        final dateFormat = DateFormat('dd/MM/yyyy');
        if (decoded is List) {
          return Future.wait(decoded.map((agendamento) async => Agendamento(
            nome: agendamento['name'],
            servico: await _carregarDados(agendamento['fk_service'].toString()),
            horario: (String dataHora) {
              List<String> partes = dataHora.split(' ');
              String hora = partes[1];
              return hora;
            }(agendamento['start']),
            dia: dateFormat.format(DateTime.parse(agendamento['start'].toString().split(" ")[0])),
            preco: await (String idService) async {
              //String myIp = IpApi.myIp;
              var url = Uri.parse('http://$myIp/phpApi/public_html/api/price/$idService');
              var response = await http.get(url);
              if (response.statusCode == 200) {
                var dados = jsonDecode(response.body);
                return dados['data']['price'];
            }
          }(agendamento['fk_service'].toString()),
          idAgendamento: agendamento['scheduling_id'],
          )).toList());
        } else if (decoded is Map<String, dynamic>) {
          return [Agendamento(
            nome: decoded['name'],
            servico: await _carregarDados(decoded['fk_service'].toString()),
            horario: (String dataHora) {
              List<String> partes = dataHora.split(' ');
              String hora = partes[1];
              return hora;
            }(decoded['start']),
            dia: dateFormat.format(DateTime.parse(decoded['start'].toString().split(" ")[0])),
            preco: await (String idService) async {
              //String myIp = IpApi.myIp;
              var url = Uri.parse('http://$myIp/phpApi/public_html/api/price/$idService');
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
}


class MySchedule extends StatefulWidget {
  @override
  _MyScheduleState createState() => _MyScheduleState();
}

class _MyScheduleState extends State<MySchedule> {
  List<Agendamento> appointments = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    try {
      final appointments = await ApiService.getAgendamentos();
      setState(() {
        this.appointments = appointments.reversed.toList();
      });
    } catch (e) {
      // Se a requisição falhar, você pode exibir uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<int> submitDeleteSchedule(String idSchedule) async {
    String myIp = IpApi.myIp;
    String apiUrl = "http://$myIp/phpApi/public_html/api/deleteScheduling";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text('Meus Agendamentos'),
        centerTitle: true,
        backgroundColor: AppColors.secundaryColor,
      ),
      body: appointments.isNotEmpty
        ? ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (BuildContext context, int index) {
              final appointment = appointments[index];
              return Card(
                color: AppColors.whiteGrayColor,
                child: ListTile(
                  title: Text('Nome: ${appointment.nome}', 
                    style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Serviço: ${appointment.servico}', 
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Dia: ${appointment.dia}', 
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Hora: ${appointment.horario}', 
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Preço: R\$ ${appointment.preco}', 
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secundaryColor,
                      minimumSize: const Size(100, 40), 
                    ),
                    child: const Text(
                      'Excluir',
                      style: TextStyle(fontSize: 18),
                      ),
                    onPressed: () async {
                      // Implementação da remoção do agendamento
                      int remover = await submitDeleteSchedule(appointment.idAgendamento);
                      if(remover == 200){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const DeletedCompleted()),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          )
        : Center(child: CircularProgressIndicator()),
    );
  }
}
