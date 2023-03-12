import 'dart:io';

import 'package:enne_barbearia/views/admin/profile_admin.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../content/cadastre_user.dart';
import '../content/login_app.dart';
import '../content/password_change.dart';

class CrudScreenAdmin extends StatelessWidget {
  CrudScreenAdmin({Key? key}) : super(key: key);

  final ButtonStyle buttonCrud = ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 240, 41, 41),
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    minimumSize: const Size(double.infinity, 48.0),
    textStyle: const TextStyle(fontSize: 18.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  void closeAppUsingExit() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secundaryColor,
        title: const Text('Central do Administrador'),
      ),
      body: Container(
          color: Colors.black,
          //child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Ação do botão "Cadastrar"
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Register()),);

                  },
                  style: buttonCrud,
                  child: const Text('Cadastrar Usuário *'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Ação do botão "Listar"
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreenAdmin()),);
                  },
                  style: buttonCrud,
                  
                  child: const Text('Perfil do Admistrador *'),
                ),
                const SizedBox(height: 16.0),
    
                ElevatedButton(
                  onPressed: () {
                    // Ação do botão "Listar" TwoElevatedButtonScreen
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => TwoElevatedButtonScreen()),);
                  },
                  style: buttonCrud,
                  
                  child: const Text('Listar Agenda'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Ação do botão "Editar"
                  },
                  style: buttonCrud,
                  child: const Text('Dias de Funcionamento'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Ação do botão "Editar"
                  },
                  style: buttonCrud,
                  child: const Text('Horários de Funfionamento'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Ação do botão "Excluir"
                  },
                  style: buttonCrud,
                  child: const Text('Serviços Disponíveis'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Ação do botão "Excluir"
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TrocarSenhaScreen()),);
                  },
                  style: buttonCrud,
                  child: const Text('Configurar Senha *'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Ação do botão "Excluir"
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginApp()));
                    //closeAppUsingExit();
                  },
                  style: buttonCrud,
                  child: const Text('Logout *'),
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