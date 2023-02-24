import 'package:enne_barbearia/views/content/content_page.dart';
import 'package:enne_barbearia/views/content/register_hour.dart';
import 'package:enne_barbearia/views/content/register_services.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class RegisterDate extends StatefulWidget {
  const RegisterDate({super.key});

  @override
  State<RegisterDate> createState() => _RegisterDateState();
}

class _RegisterDateState extends State<RegisterDate> {

  final dropValue = ValueNotifier('');
  DateTime today = DateTime.now();
  // ignore: non_constant_identifier_names
  void _select_day(DateTime day, DateTime focusedDay){
    setState(() {
      today = day;
    });
    print(today.toString().split(" ")[0]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("2 - Data"),
         backgroundColor: AppColors.primaryColor,
         centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.primaryColor,
      body: Container(
        child: ListView(
        children: [

          /*
          Container(
            // ignore: prefer_const_constructors
            child: Padding(
              padding: const EdgeInsets.only(top:100.0, left: 50.0),
              child: const Text(
                '2 - Data',
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.textColor
                  )
                ),
              ),
            ),*/
          const SizedBox(height: 50),
          WidgetCalenar(),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.all(35)),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secundaryColor,
                minimumSize: Size(125, 40), 
                //padding: EdgeInsets.only(left: 20)
              
              ),
              onPressed: () {
                //BOTÃO VOLTAR ...
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterService()),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secundaryColor,
                minimumSize: const Size(100, 40), 
              ),
              onPressed: () {
                // CONTINUAR AGENDAMENTO ...
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TimeSlotsPage()),
                );
              },
              child: const Text(
                'Prosseguir',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textColor
                  )
                ),
              ),
            ],
          )
          ]
        )
      )
    );
  }
  Widget WidgetCalenar(){
    // estudar https://pub.dev/packages/table_calendar
    // https://www.youtube.com/watch?v=6Gxa-v7Zh7I
    return Container( 
    //Column(
      //children: [
        //Container(
        color: AppColors.secundaryColor,
        padding: const EdgeInsets.all(5),
        //decoration: ,
        child: TableCalendar(
          //rowHeight: 50,
          locale: 'pt_BR',
          headerStyle: const HeaderStyle(
            formatButtonVisible: false, 
            titleCentered: true, 
            titleTextStyle: TextStyle(
              color: AppColors.textColor, 
              fontSize: 26,
              ),
            formatButtonDecoration: BoxDecoration(color: Colors.white),
            ),
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: AppColors.textColor), 
            weekendStyle: TextStyle(color: AppColors.textColor)
            ),
          selectedDayPredicate: (day) => isSameDay(day, today),
          calendarStyle: const CalendarStyle(
            //rangeHighlightColor: Colors.green,
            //markerDecoration: BoxDecoration(color: Colors.orange),
            //todayTextStyle: TextStyle(color: Colors.red), // muda a cor do selecionado
            defaultTextStyle: TextStyle(color: AppColors.textColor), //  muda a cor geral dos dias do mes
            //rangeStartTextStyle: TextStyle(color: AppColors.textColor),
            //rangeEndTextStyle: TextStyle(color: Colors.blue),
            weekendTextStyle: TextStyle(color: Color.fromARGB(255, 218, 216, 216)), // muda cor dos finais de semana
            todayTextStyle: TextStyle(color: Colors.white),
            ),
          focusedDay: today,
          firstDay: DateTime.utc(2023,01,01),
          lastDay: DateTime.utc(2024,01,01),
          onDaySelected: _select_day,
          ),
        //)
      //]
    );
  }
}