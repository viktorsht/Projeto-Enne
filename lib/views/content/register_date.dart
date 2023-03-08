//import 'package:enne_barbearia/views/content/contato_page.dart';
//import 'package:enne_barbearia/views/content/register_hour.dart';
import 'package:enne_barbearia/views/content/register_hour.dart';
import 'package:enne_barbearia/views/content/register_services.dart';
import 'package:enne_barbearia/views/content/selec.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

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

  void _onDaySelect(DateTime day, DateTime focusedDay){
    setState(() {
      if(!isDateInPast(day) &&  day.weekday != DateTime.sunday){ 
        // só habilita dias que são iguais ou posteriores a data de hoje e elimina os domingos.
        today = day;
        print(today.toString().split(" ")[0]);
        dataIngles = today.toString().split(" ")[0]; // printa no console a data selecionada.
        mensagem = dateFormat.format(DateTime.parse(dataIngles)); // converte formado da data para portugues
      }
    });
  }

  bool isDateInPast(DateTime date) {
  
    //a função retorna verdadeiro (true) se a data passada como parâmetro ocorreu até o dia de ontem, e falso (false) caso contrário.

    final now = DateTime.now();
    return date.isBefore(DateTime(now.year, now.month, now.day - 1));
  }

  final style_buton = ElevatedButton.styleFrom( backgroundColor: AppColors.secundaryColor,minimumSize: const Size(100, 40),);

  List<String> items = [
  'Item 1',
  'Item 2',
  'Item 3',
  'Item 4',
  'Item 5',
];
int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecione a data", ),
        backgroundColor: AppColors.secundaryColor,
        centerTitle: true,
      ),
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          const SizedBox(height: 16,),
          Text('Data selecionada: $mensagem', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: AppColors.textColor)),
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
                style: style_buton,
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
                style: style_buton,
                onPressed: () {
                  // CONTINUAR AGENDAMENTO ...
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterHour()),);
                  if(dataIngles == ''){
                    serviceApi.start = DateTime.now().toString().split(" ")[0];
                  }
                  else{
                    serviceApi.start = dataIngles;
                  }
                  print(serviceApi.start);
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

