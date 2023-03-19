import 'dart:convert';
import 'package:enne_barbearia/views/admin/edit_confirm_day.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../api.dart';

class DayOfWeek {
  String id;
  String name;
  String status;

  DayOfWeek({required this.id, required this.name, this.status = "0"});

  factory DayOfWeek.fromJson(Map<String, dynamic> json) {
    return DayOfWeek(
      id: json['id'],
      name: json['name'],
      status: json['status'] ?? "0",
    );
  }
}

Future<List<DayOfWeek>> fetchDaysOfWeek() async {
  String url = "${DataApi.urlBaseApi}dayActive";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final daysOfWeekData = List<Map<String, dynamic>>.from(data['data'] ?? []);
    return daysOfWeekData.map((item) => DayOfWeek.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load days of week: ${response.reasonPhrase}');
  }
}

class DaysOfWeekScreen extends StatefulWidget {
  @override
  _DaysOfWeekScreenState createState() => _DaysOfWeekScreenState();
}

class _DaysOfWeekScreenState extends State<DaysOfWeekScreen> {
  late Future<List<DayOfWeek>> futureDaysOfWeek;
  List<String> daysActiveLista = [];

  void removerDadosRepetidos(String id, List<String> lista) {
  if (lista.contains(id)) {
    int index = lista.indexOf(id);
    lista.removeAt(index);
    lista.removeAt(index);
  }
}

  final styleButon = ElevatedButton.styleFrom( backgroundColor: AppColors.secundaryColor,minimumSize: const Size(100, 40),);

  Future<int> submitUpdateDayActiveApi(var id, var status) async {
    String apiUrl = "${DataApi.urlBaseApi}dayActive/";
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
        title: const Text('Dias de funcionamento'),
        centerTitle: true,
        backgroundColor: AppColors.secundaryColor,
      ),
      body: Center(
        child: FutureBuilder<List<DayOfWeek>>(
          future: futureDaysOfWeek,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  const SizedBox(height: 40),
                  ...snapshot.data!.map((dayOfWeek) {
                    return CheckboxListTile(
                      selectedTileColor: AppColors.secundaryColor,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(dayOfWeek.name),
                      value: dayOfWeek.status == "0",
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            dayOfWeek.status = value ? "0" : "1";
                            //print("Dia: ${dayOfWeek.id} - Status: ${dayOfWeek.status}");
                            if(daysActiveLista == []){
                              daysActiveLista.add(dayOfWeek.id);
                              daysActiveLista.add(dayOfWeek.status);
                            }
                            else{
                              removerDadosRepetidos(dayOfWeek.id, daysActiveLista);
                              daysActiveLista.add(dayOfWeek.id);
                              daysActiveLista.add(dayOfWeek.status);
                            }
                            print("\n\nLista de dias :  $daysActiveLista");
                          });
                        }
                      },
                      
                    );
                  }).toList(),
                  ElevatedButton(
                    onPressed: () async {
                      int retornoApi = await enviarDadosParaAPI(daysActiveLista);
                      if(retornoApi == 0){
                        // mensagem de ok
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditConfirmDay()));
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Houve um erro, tente novamente!'),
                            duration: Duration(seconds: 3),
                            backgroundColor: AppColors.secundaryColor,
                          ),
                        );
                      }
                    },
                    style: styleButon,
                    child: const Text('Atualizar', style: TextStyle(fontSize: 20),),
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


