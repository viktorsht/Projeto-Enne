import 'package:enne_barbearia/views/admin/edit_confirm_timeActive.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
/*
import 'dart:convert';
import '../../api.dart';
import '../../models/duration.dart';
import '../../models/service.dart';
import '../theme/app_colors.dart';

faça um Get numa api e salve os dados de ['data']['time'] em uma lista de string para ser usada em uma ListView no Flutter
incremente o que foi feito anteriormente com um checkBox onde o usuário só pode selecionar um único item da listView

class TimeActive extends StatefulWidget {
  @override
  _TimeActiveState createState() => _TimeActiveState();
}

class _TimeActiveState extends State<TimeActive> {

  SchedulingApiAppRequest serviceApi = SchedulingApiAppRequest();

  bool _isLoading = true;

Future<List<String>> getTimeActiveApi() async {
  String day = Day.idDay;
  final response = await http.get(Uri.parse('${DataApi.urlBaseApi}timeActive/$day'));
  
  if (response.statusCode == 200) {
    _isLoading = false;
    List<dynamic> responseData = jsonDecode(response.body)['data'];
    List<String> timeList = [];

    for (var data in responseData) {
      timeList.add(data['time']);
    }

    return timeList;
  } else {
    throw Exception('Requisição falida');
  }
}


  List<String> timeList = [];
  int _selectedIndex = -1;
  List<String> horariosAtualizados = [];

  @override
  void initState() {
    super.initState();
    getTimeActiveApi().then((list) {
      setState(() {
        timeList = list;
        //SchedulingApiAppRequest.numeroDiaSemana = 0;
      });
    });
  }

  final style_buton = ElevatedButton.styleFrom( backgroundColor: AppColors.secundaryColor,minimumSize: const Size(100, 40),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteGrayColor,
      appBar: AppBar(
        title: const Text("Selecione a hora"),
        backgroundColor: AppColors.secundaryColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading 
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
            itemCount: timeList.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckboxListTile(
                tileColor: AppColors.whiteGrayColor,
                //tileColor: AppColors.secundaryColor,
                selectedTileColor: AppColors.secundaryColor,
                activeColor: AppColors.secundaryColor,
                title: Text(timeList[index], style: const TextStyle(color: AppColors.primaryColor),),
                value: timeList[index],
                onChanged: (value) {

                },
                );
              },
            ),
          ),
          ElevatedButton(
            style: style_buton,
            onPressed: () {
              // CONTINUAR AGENDAMENTO ...
              
              if(_selectedIndex == -1){
                //serviceApi.start = DateTime.now().toString().split(" ")[0];
                // tem que aparecer um alerta aqui!!!
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Insira um horário, por favor!'),
                    duration: Duration(seconds: 3),
                    backgroundColor: AppColors.secundaryColor,
                  ),
                );
              }
              else{
                //serviceApi.start = dataIngles;
                /*
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AgendamentoCard(
                    data:SchedulingApiAppRequest.dataEmPtBr, 
                    servico: SchedulingApiAppRequest.namefkService, 
                    horario: SchedulingApiAppRequest.hourStart, 
                    preco: SchedulingApiAppRequest.precoService
                    )
                  ),
                );*/
              }
              //print('retorno: ${serviceApi.contatenaData(SchedulingApiAppRequest.hourStart)}'); // data completa
              
            },
            child: const Text(
              'Atualizar',
              style: TextStyle(fontSize: 20,color: AppColors.textColor)
            ),
          ),
        ],
      ),
    );
  }
}
 */

import '../../api.dart';
import '../../models/duration.dart';
import '../theme/app_colors.dart';

class Horario {
  String id;
  String status;
  String time;

  Horario({required this.id, required this.status, required this.time});

  factory Horario.fromJson(Map<String, dynamic> json) {
    return Horario(
      id: json['id'],
      status: json['status'],
      time: json['time'],
    );
  }
}

Future<List<Horario>> fetchDaysOfWeek() async {
  String day = Day.idDay;
  final response = await http.get(Uri.parse('${DataApi.urlBaseApi}timeActive/$day'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final daysOfWeekData = List<Map<String, dynamic>>.from(data['data'] ?? []);
    return daysOfWeekData.map((item) => Horario.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load days of week: ${response.reasonPhrase}');
  }
}


class TimeActive extends StatefulWidget {
  @override
  _TimeActiveState createState() => _TimeActiveState();
}

class _TimeActiveState extends State<TimeActive> {
  late Future<List<Horario>> futureDaysOfWeek;
  List<String> horariosAtivosList = [];
  String diaSelecionado = "";
  String mensagem = "Selecione os horários";

  void removerDadosRepetidos(String id, List<String> lista) {
    if (lista.contains(id)) {
      int index = lista.indexOf(id);
      lista.removeAt(index);
      lista.removeAt(index);
    }
  }

  Future<int> submitUpdateDayActiveApi(var id, var status) async {
    String apiUrl = "${DataApi.urlBaseApi}timeActive/";
    String parametros = 'id=$id&status=$status';
    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded',},
        body: parametros,
      );
      if (response.statusCode == 200) {
        print("Dia de funcionamento cadastrado: ${response.body}");
        return response.statusCode;
      } else {
        print("Dia de funcionamento não cadastrado: ${response.statusCode}");
        return response.statusCode;
      }
    } catch (e) {
      print("Erro no cadastro: $e");
    }
    return 0;
  }

  Future<int> enviarDadosParaAPI(List<String> lista) async {
    int retorno = 0;
    try{
      for (int i = 0; i < lista.length; i += 2) {
        String id = lista[i];
        String status = lista[i + 1];
        submitUpdateDayActiveApi(id, status);
      }
    }
    catch(e){
      print("Erro no cadastro: $e");
      retorno = 1;
    }
    return retorno;
  }

  final styleButon = ElevatedButton.styleFrom( backgroundColor: AppColors.secundaryColor,minimumSize: const Size(100, 40),);

  @override
  void initState() {
    super.initState();
    futureDaysOfWeek = fetchDaysOfWeek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteGrayColor,
      appBar: AppBar(
        title: const Text('Horários de funcionamento'),
        centerTitle: true,
        backgroundColor: AppColors.secundaryColor,
      ),
      body: Center(
        child: FutureBuilder<List<Horario>>(
          future: futureDaysOfWeek,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                children: [
                    const SizedBox(height: 40),
                    Text(mensagem, style: const TextStyle(
                      fontSize: 25,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold
                    ),),
                    const SizedBox(height: 40),
                    ...snapshot.data!.map((dayOfWeek) {
                      return CheckboxListTile(
                        title: Text(dayOfWeek.time),
                        value: dayOfWeek.status == '0', 
                        onChanged: (value){
                          setState(() {
                            if(value != null){
                              //dayOfWeek.status = "1";
                              dayOfWeek.status = value ? "0" : "1";
                              if(horariosAtivosList == []){
                                horariosAtivosList.add(dayOfWeek.id);
                                horariosAtivosList.add(dayOfWeek.status);
                              }
                              else{
                                removerDadosRepetidos(dayOfWeek.id, horariosAtivosList);
                                horariosAtivosList.add(dayOfWeek.id);
                                horariosAtivosList.add(dayOfWeek.status);
                              }
                              print(horariosAtivosList);
                            }
                          });
                        }
                        );
                    }).toList(),
                    ElevatedButton(
                      onPressed: () async {
                        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => TimeActive()));
                        int retorno = await enviarDadosParaAPI(horariosAtivosList);
                        if(retorno == 0){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditConfirmTimeActive()));
                        }
                        else{
                          setState(() {
                            mensagem = "Erro! Tente novamente!";
                          });
                        }
                      },
                      style: styleButon,
                      child: const Text('Atualizar', style: TextStyle(fontSize: 20),),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
