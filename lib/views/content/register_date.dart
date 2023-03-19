import 'dart:convert';

import 'package:enne_barbearia/views/content/register_hour.dart';
import 'package:enne_barbearia/views/content/register_services.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../api.dart';
import '../../models/day_week.dart';
import '../../models/service.dart';

class RegisterDate extends StatefulWidget {
  const RegisterDate({super.key});

  @override
  State<RegisterDate> createState() => _RegisterDateState();
}

class _RegisterDateState extends State<RegisterDate> {

  SchedulingApiAppRequest serviceApi = SchedulingApiAppRequest();

  DateTime today = DateTime.now();
  String dataIngles= DateTime.now().toString().split(" ")[0];
  final dateFormat = DateFormat('dd/MM/yyyy');
  String mensagem = DateFormat('dd/MM/yyyy').format(DateTime.parse(DateTime.now().toString().split(" ")[0]));
  String msgTela = "Selecione uma data";
  List<String> diaAtivo = [];
  late Future<List<DiaSemana>> futureDaysOfWeek;


  void _onDaySelect(DateTime day, DateTime focusedDay){
    setState(() {
      if(!isDateInPast(day) &&  day.weekday != DateTime.sunday){ 
        // só habilita dias que são iguais ou posteriores a data de hoje e elimina os domingos.
        today = day;
        SchedulingApiAppRequest.numeroDiaSemana = day.weekday;
        //print(today.toString().split(" ")[0]);
        dataIngles = today.toString().split(" ")[0]; // printa no console a data selecionada.
        mensagem = dateFormat.format(DateTime.parse(dataIngles)); // converte formado da data para portugues
        SchedulingApiAppRequest.dataEmPtBr = mensagem;
        msgTela = "Data selecionada: $mensagem";
      }
    });
  }

  bool isDateInPast(DateTime date) {
  
    //a função retorna verdadeiro (true) se a data passada como parâmetro ocorreu até o dia de ontem, e falso (false) caso contrário.

    final now = DateTime.now();
    return date.isBefore(DateTime(now.year, now.month, now.day - 1));
  }

  final styleButon = ElevatedButton.styleFrom( backgroundColor: AppColors.secundaryColor,minimumSize: const Size(100, 40),);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecione a data", ),
        backgroundColor: AppColors.secundaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          const SizedBox(height: 16,),
          Text(msgTela, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: AppColors.textColor)),
          const SizedBox(height: 16,),
          Container(
            color: AppColors.secundaryColor,//Colors.red,
            child: TableCalendar(
          locale: 'pt_BR',
          headerStyle: const HeaderStyle(
            formatButtonVisible: false, 
            titleCentered: true,
            titleTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
          ),
            //),
          availableGestures: AvailableGestures.all,
          selectedDayPredicate: (day) => isSameDay(today, day) && ( day.weekday != DateTime.sunday),//day) => !isDateInPast(day) && day.weekday != DateTime.sunday),
          focusedDay: today, 
          firstDay: DateTime.utc(2023, 01, 01), 
          lastDay: DateTime.utc(2024, 01, 01),
          onDaySelected: _onDaySelect,
          calendarStyle: const CalendarStyle(
              defaultTextStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.white),
              //selectedTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: Colors.black),
              todayTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: Colors.white,),
              weekendTextStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.white),
              //weekdayTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0, color: Colors.blue,
              ),
          daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0, color: Colors.white,),
              weekendStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0, color: Colors.white,),
              ),
            ),
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.all(35)),
              ElevatedButton(
                style: styleButon,
                onPressed: () {
                  // CONTINUAR AGENDAMENTO ...
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterService()),);
                },
                child: const Text(
                  'Voltar',
                  style: TextStyle(fontSize: 20,color: AppColors.textColor)
                  ),
                ),
              const SizedBox(width: 25,),
              ElevatedButton(
                style: styleButon,
                onPressed: () {
                  // CONTINUAR AGENDAMENTO ...
                  if(SchedulingApiAppRequest.numeroDiaSemana == 0){
                    ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Insira um horário, por favor!'),
                    duration: Duration(seconds: 3),
                    backgroundColor: AppColors.secundaryColor,
                  ),
                );
                  }
                  else{
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterHour()),);
                    if(dataIngles == ''){
                      SchedulingApiAppRequest.dateStart = DateTime.now().toString().split(" ")[0];
                    }
                    else{
                      SchedulingApiAppRequest.dateStart = dataIngles;
                    }
                    //SchedulingApiAppRequest.numeroDiaSemana = 0;
                  }
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

