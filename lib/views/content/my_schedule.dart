import 'dart:convert';
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
  String preco;

  Agendamento({required this.nome, required this.servico, required this.horario, required this.preco});
}
/*
class ApiService {
  List<dynamic> _dados = [];

  static Future<String> _carregarDados(String id_service) async {
    String myIp = IpApi.myIp;
    var url = Uri.parse('http://$myIp/phpApi/public_html/api/service/$id_service');
    var response = await http.get(url);
    var dados = jsonDecode(response.body);
    return dados['data']['name'];
  }

  static Future<List<Agendamento>> getAgendamentos() async {
    String myIp = IpApi.myIp;
    String id = UserActiveApp.idUser;
    var url = 'http://$myIp/phpApi/public_html/api/scheduling/$id';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      if (jsonResponse != null && jsonResponse.isNotEmpty) {
        dynamic decoded = jsonDecode(jsonResponse);
        decoded = decoded['data'];
        dynamic service = decoded['data']['fk_service'];
        //print(service);
        service = _carregarDados(service.toString());
        print("Service: ${service}");
        if (decoded is List) {
          return decoded.map((agendamento) => Agendamento(
            nome: agendamento['name'],
            servico: agendamento['fk_service'],
            horario: agendamento['start']
          )).toList();
        } else if (decoded is Map<String, dynamic>) {
          return [Agendamento(
            nome: decoded['name'],
            servico: decoded['fk_service'],
            horario: decoded['start']
          )];
          //print("Estou aqui");
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
*/

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
            //horario: agendamento['start']
            horario: dateFormat.format(DateTime.parse(agendamento['start'].toString().split(" ")[0])),
            preco: await (String idService) async {
              String myIp = IpApi.myIp;
              var url = Uri.parse('http://$myIp/phpApi/public_html/api/price/$idService');
              //var url = Uri.parse('http://$myIp/phpApi/public_html/api/price/$idfkService');
              var response = await http.get(url);
          
              if (response.statusCode == 200) {
                var dados = jsonDecode(response.body);
                //print('Dados do usuário: ${dados['data']}');
                return dados['data']['price'];
            }
          }(agendamento['fk_service'].toString()),
          )).toList());
        } else if (decoded is Map<String, dynamic>) {
          return [Agendamento(
            nome: decoded['name'],
            servico: await _carregarDados(decoded['fk_service'].toString()),
            //horario: decoded['start']
            horario: dateFormat.format(DateTime.parse(decoded['start'].toString().split(" ")[0])),
            preco: await (String idService) async {
              String myIp = IpApi.myIp;
              var url = Uri.parse('http://$myIp/phpApi/public_html/api/price/$idService');
              //var url = Uri.parse('http://$myIp/phpApi/public_html/api/price/$idfkService');
              var response = await http.get(url);
          
              if (response.statusCode == 200) {
                var dados = jsonDecode(response.body);
                //print('Dados do usuário: ${dados['data']}');
                return dados['data']['price'];
            }
          }(decoded['fk_service'].toString()),
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
                  //title: Text(appointment.nome),
                  title: Text('Nome: ${appointment.nome}', 
                    style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  //subtitle: Text('${appointment.servico} - ${appointment.horario.toString()}'),
                  subtitle: Text(
                    'Serviço: ${appointment.servico}   Horário: ${appointment.horario}  Preço: R\$ ${appointment.preco}', 
                    //textAlign: TextAlign.justify,
                    //softWrap: true,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                ),
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
                    onPressed: () {
                      // Aqui você pode implementar a lógica para excluir o agendamento
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
