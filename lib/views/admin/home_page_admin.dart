import 'dart:io';

import 'package:enne_barbearia/views/admin/dayToday.dart';
import 'package:enne_barbearia/views/admin/edit_day_active.dart';
import 'package:enne_barbearia/views/admin/edit_services.dart';
import 'package:enne_barbearia/views/admin/timeActive.dart';
import 'package:enne_barbearia/views/admin/profile_admin.dart';
import 'package:enne_barbearia/views/admin/schedule_all.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../content/cadastre_user.dart';
import '../content/login_app.dart';
import '../content/password_change.dart';

class HomePageAdmin extends StatelessWidget {
  HomePageAdmin({Key? key}) : super(key: key);

  final ButtonStyle buttonCrud = ElevatedButton.styleFrom(
    backgroundColor: AppColors.secundaryColor,
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    minimumSize: const Size(double.infinity, 48.0),
    textStyle: const TextStyle(fontSize: 18.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secundaryColor,
        title: const Text('Central do Administrador'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
          color: AppColors.primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Register()),);

                  },
                  style: buttonCrud,
                  child: const Text('Cadastrar Usuário'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreenAdmin()),);
                  },
                  style: buttonCrud,
                  
                  child: const Text('Perfil do Admistrador'),
                ),
                const SizedBox(height: 16.0),
    
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyScheduleAll()),);
                  },
                  style: buttonCrud,
                  child: const Text('Listar Agenda'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DaysOfWeekScreen()),);
                  },
                  style: buttonCrud,
                  child: const Text('Dias de Funcionamento'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  DayToday()),);

                  },
                  style: buttonCrud,
                  child: const Text('Horários de Funcionamento'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const EditServices()),);
                  },
                  style: buttonCrud,
                  child: const Text('Serviços Disponíveis'), // EditServices
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TrocarSenhaScreen()),);
                  },
                  style: buttonCrud,
                  child: const Text('Configurar Senha'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginApp()));
                  },
                  style: buttonCrud,
                  child: const Text('Sair'),
                ),
              ],
            ),
          ),
        );
        //}
     // );
    //);
  }
}