import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  TimeOfDay time = TimeOfDay.now(); // hora atual

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Horário"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        ),
      backgroundColor: AppColors.primaryColor,
      body: ListView(
        children: [
        ],
      )
    );
  }
  
}