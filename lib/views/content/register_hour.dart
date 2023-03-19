import 'dart:convert';

import 'package:enne_barbearia/views/content/confirm_schedule.dart';
import 'package:enne_barbearia/views/content/register_date.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../api.dart';
import '../../models/service.dart';
import '../../models/set_date_hour.dart';
import '../theme/app_colors.dart';

/*
faça um Get numa api e salve os dados de ['data']['time'] em uma lista de string para ser usada em uma ListView no Flutter
incremente o que foi feito anteriormente com um checkBox onde o usuário só pode selecionar um único item da listView
 */

class RegisterHour extends StatefulWidget {
  @override
  _RegisterHourState createState() => _RegisterHourState();
}

class _RegisterHourState extends State<RegisterHour> {

  SchedulingApiAppRequest serviceApi = SchedulingApiAppRequest();

  bool _isLoading = true;

  SetDateHour setDateHour = SetDateHour(); // cuida da validação de datas e horas

  Future<List<String>> getTimeActiveApi() async {
    String day = SchedulingApiAppRequest.numeroDiaSemana.toString();
    final response = await http.get(Uri.parse('${DataApi.urlBaseApi}timeActive/$day'));
    
    if (response.statusCode == 200) {
      _isLoading = false;
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


  List<String> timeList = [];
  int _selectedIndex = -1;

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


  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      SchedulingApiAppRequest.hourStart = timeList[_selectedIndex];
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
        automaticallyImplyLeading: false,
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
                value: _selectedIndex == index,
                onChanged: (value) => _onItemTap(index),
                );
              },
            ),
          ),
          Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.all(35)),
            ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secundaryColor,
              minimumSize: const Size(125, 40), 
            ),
            onPressed: () {
              //BOTÃO VOLTAR ...
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const RegisterDate()),
              );
            },
            child: const Text(
              'Voltar',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.textColor
                )
              ),
            ),
            const SizedBox(width: 25,),
            ElevatedButton(
            style: style_buton,
            onPressed: () async {
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
                int valida = await validaSchedule(serviceApi.contatenaData(SchedulingApiAppRequest.hourStart));
                if (valida != 200){  
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AgendamentoCard(
                      data:SchedulingApiAppRequest.dataEmPtBr, 
                      servico: SchedulingApiAppRequest.namefkService, 
                      horario: SchedulingApiAppRequest.hourStart, 
                      preco: SchedulingApiAppRequest.precoService
                      )
                    ),
                  );
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Esse horário está ocupado! tente novamente'),
                    duration: Duration(seconds: 3),
                    backgroundColor: AppColors.secundaryColor,
                  ),
                );
                }
                serviceApi.contatenaData(SchedulingApiAppRequest.hourStart);
                }
              //print('retorno: ${serviceApi.contatenaData(SchedulingApiAppRequest.hourStart)}'); // data completa
              
            },
            child: const Text(
              'Prosseguir',
              style: TextStyle(fontSize: 20,color: AppColors.textColor)
            ),
          ),
          ],
        )
        ],
      ),
    );
  }
}

