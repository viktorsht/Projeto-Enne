import 'package:enne_barbearia/views/admin/edit_confirm_timeActive.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
