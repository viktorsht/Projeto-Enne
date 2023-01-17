import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final ValueNotifier<DateTime?> dateSub = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WidgetCalenar(),
    );
  }
  Widget WidgetCalenar(){
    // estudar https://pub.dev/packages/table_calendar
    // https://www.youtube.com/watch?v=6Gxa-v7Zh7I
    return Column(
      children: [
        Container(
        child: TableCalendar(
          calendarStyle: CalendarStyle(),
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2023,01,01),
          lastDay: DateTime.utc(2024,01,01)
          ),
        ),
      ]
    );
  }
}