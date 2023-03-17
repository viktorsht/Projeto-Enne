import 'dart:convert';
import 'package:enne_barbearia/models/duration.dart';
import 'package:enne_barbearia/views/admin/timeActive.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../api.dart';

class DiasSemana {
  String id;
  String name;
  String status;

  DiasSemana({required this.id, required this.name, required this.status});

  factory DiasSemana.fromJson(Map<String, dynamic> json) {
    return DiasSemana(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }
}

Future<List<DiasSemana>> fetchDaysOfWeek() async {
  String url = "${DataApi.urlBaseApi}dayActive";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final daysOfWeekData = List<Map<String, dynamic>>.from(data['data'] ?? []);
    print(daysOfWeekData);
    return daysOfWeekData.map((item) => DiasSemana.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load days of week: ${response.reasonPhrase}');
  }
}

class DayToday extends StatefulWidget {
  @override
  _DayTodayState createState() => _DayTodayState();
}

class _DayTodayState extends State<DayToday> {
  late Future<List<DiasSemana>> futureDaysOfWeek;
  List<String> daysActiveLista = [];
  String diaSelecionado = "";
  String mensagem = "Selecione um dia";

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
        title: const Text('Dias da semana'),
        centerTitle: true,
        backgroundColor: AppColors.secundaryColor,
      ),
      body: Center(
        child: FutureBuilder<List<DiasSemana>>(
          future: futureDaysOfWeek,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  const SizedBox(height: 40),
                  Text(mensagem, style: const TextStyle(
                    fontSize: 25,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold
                  ),),
                  const SizedBox(height: 40),
                  ...snapshot.data!.map((dayOfWeek) {
                    return RadioListTile(
                      title: Text(dayOfWeek.name),
                      value: dayOfWeek.id, 
                      groupValue: diaSelecionado, 
                      onChanged: (value){
                        if(value != null){
                          setState(() {
                            if(dayOfWeek.status != '1'){
                              diaSelecionado = dayOfWeek.id;
                              Day.idDay = dayOfWeek.id;
                              print("Id do dia ${dayOfWeek.name} = ${Day.idDay}");
                              mensagem = dayOfWeek.name;
                            }
                            else{
                              setState(() {
                                mensagem = "${dayOfWeek.name} não está ativo";
                              });
                            }
                          });
                        }
                      }
                      );
                  }).toList(),
                  ElevatedButton(
                    onPressed: () async {
                      if(diaSelecionado != ""){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TimeActive()));
                      }
                    },
                    style: styleButon,
                    child: const Text('Prosseguir', style: TextStyle(fontSize: 20),),
                  ),
                ],
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


