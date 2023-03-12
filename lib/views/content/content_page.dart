import 'dart:convert';

import 'package:enne_barbearia/models/userActive.dart';
import 'package:enne_barbearia/views/content/deleted_completed.dart';
import 'package:enne_barbearia/views/content/my_schedule.dart';
import 'package:enne_barbearia/views/content/navigation.dart';
import 'package:enne_barbearia/views/content/register_services.dart';
import 'package:enne_barbearia/views/content/profile_screen.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../ip_api.dart';
import '../../models/service.dart';



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
    var url = Uri.parse('${DataApi.urlBaseApi}service/$idService');
    var response = await http.get(url);
    var dados = jsonDecode(response.body);
    return dados['data']['name'];
  }

  static Future<List<Agendamento>> getAgendamentos() async {
    String id = UserActiveApp.idUser;
    SchedulingApiAppRequest serviceApi = SchedulingApiAppRequest();

    var url = '${DataApi.urlBaseApi}scheduling/$id';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      if (jsonResponse.isNotEmpty) {
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
}



class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage>{
  List<Agendamento> appointments = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
    //getSchedulingUser().then((list) {setState(() {scheduleList = list;});});
    //getSchedulingUser();
    //print("Lista de Agendas: $scheduleList");
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

  @override
  Widget build(BuildContext context) {

    final ButtonStyle themeButtonGeneral = ElevatedButton.styleFrom(
      backgroundColor: AppColors.secundaryColor,
      minimumSize: const Size(100, 50),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
  );

    return Scaffold(
      //bakccolor: AppColors.primaryColor,
      backgroundColor: AppColors.primaryColor,
      drawer: const Navigation(),
      appBar: AppBar(
        title: const Text('Enne'),
        centerTitle: true,
        backgroundColor: AppColors.secundaryColor,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen()));
          },
        icon: const Icon(Icons.person)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox( width: 150, height: 160, child: Image.asset('assets/logo.png'),),
              const SizedBox(height: 30,),
              SizedBox(
                height: 200,
                child: appointments.isNotEmpty
                ? ListView.builder(
                    itemCount: appointments.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final appointment = appointments[index];
                      return Card(
                        color: AppColors.whiteGrayColor,
                        child: SizedBox(
                          width: 300,
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
                              const SizedBox(height: 10,),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secundaryColor,
                                  minimumSize: const Size(80, 40), 
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
                                      MaterialPageRoute(builder: (context) => const TelaConfirmacaoDeleteSchedule()),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),/*
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secundaryColor,
                              minimumSize: const Size(80, 40), 
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
                                  MaterialPageRoute(builder: (context) => const TelaConfirmacaoDeleteSchedule()),
                                );
                              }
                            },
                          ),*/
                        ),
                        ),
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
                ),
              //MySchedule(),
              const SizedBox(height: 30,),
              ElevatedButton(
                style: themeButtonGeneral,
                onPressed: () {
                //Cadastro concluído com sucesso
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterService()),);
                },
                child: const Text(
                  'Agendar agora!',
                  style: TextStyle(
                    fontSize: 25, color: AppColors.textColor
                  )
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
