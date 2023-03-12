import 'dart:convert';

import 'package:enne_barbearia/views/content/confirm_schedule.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../ip_api.dart';
import '../../models/service.dart';
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

Future<List<String>> getTimeActiveApi() async {
  String day = SchedulingApiAppRequest.numeroDiaSemana.toString();
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

  @override
  void initState() {
    super.initState();
    getTimeActiveApi().then((list) {
      setState(() {
        timeList = list;
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
          ElevatedButton(
            style: style_buton,
            onPressed: () {
              // CONTINUAR AGENDAMENTO ...
              
              if(_selectedIndex == -1){
                //serviceApi.start = DateTime.now().toString().split(" ")[0];
                // tem que aparecer um alerta aqui!!!
              }
              else{
                //serviceApi.start = dataIngles;
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
              print('retorno: ' + serviceApi.contatenaData(SchedulingApiAppRequest.hourStart)); // data completa
              
            },
            child: const Text(
              'Prosseguir',
              style: TextStyle(fontSize: 20,color: AppColors.textColor)
            ),
          ),
        ],
      ),
    );
  }
}

