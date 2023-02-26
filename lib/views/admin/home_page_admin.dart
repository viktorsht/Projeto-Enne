import 'package:enne_barbearia/views/admin/profile_admin.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../content/cadastre_user.dart';
import '../content/password_change.dart';

class CrudScreenAdmin extends StatelessWidget {
  CrudScreenAdmin({Key? key}) : super(key: key);

  final ButtonStyle button_crud = ElevatedButton.styleFrom(
    backgroundColor: AppColors.secundaryColor,
    padding: EdgeInsets.symmetric(vertical: 16.0),
    minimumSize: Size(double.infinity, 48.0),
    textStyle: TextStyle(fontSize: 18.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secundaryColor,
        title: Text('Central do Administrador'),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Ação do botão "Cadastrar"
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Register()),);

                },
                style: button_crud,
                child: Text('Cadastrar Usuário *'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Ação do botão "Listar"
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreenAdmin()),);
                },
                style: button_crud,
                
                child: Text('Perfil do Admistrador *'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Ação do botão "Listar"
                },
                style: button_crud,
                
                child: Text('Listar Agenda'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Ação do botão "Editar"
                },
                style: button_crud,
                child: Text('Dias de Funcionamento'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Ação do botão "Editar"
                },
                style: button_crud,
                child: Text('Horários de Funfionamento'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Ação do botão "Excluir"
                },
                style: button_crud,
                child: Text('Serviços Disponíveis'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Ação do botão "Excluir"
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TrocarSenhaScreen()),);
                },
                style: button_crud,
                child: Text('Configurar Senha *'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//import 'package:flutter/material.dart';ProfileScreenAdmin


