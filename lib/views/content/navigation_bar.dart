import 'dart:convert';
import 'dart:io';

import 'package:enne_barbearia/views/content/login_app.dart';
import 'package:enne_barbearia/views/content/register_services.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:enne_barbearia/views/content/content_page.dart';
import 'package:flutter/material.dart';

import '../../models/userActive.dart';


class NavBar extends StatelessWidget {
  NavBar({super.key});


  void closeAppUsingExit() {
    exit(0);
  }

  String retorno = UserActiveApp.idUser;
  String name = UserActiveApp.nameUser;
  String email = UserActiveApp.emailUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //https://www.youtube.com/watch?v=SLR8U55FpFQ ASSISTIR PARA APRENDER
      child: ListView(
        padding: EdgeInsets.zero,
          children: [
          UserAccountsDrawerHeader(
            //backgroundColor: AppColors.primaryColor
            accountName: Text('Olá, $name', style: const TextStyle(fontSize: 22),), 
            accountEmail: Text('$email', style: const TextStyle(fontSize: 18)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(child: Image.asset('assets/logo.png', fit: BoxFit.cover)),
            ),
            decoration: const BoxDecoration(color: AppColors.secundaryColor),
          ),
          /*
          ListTile(
            leading: const Icon(Icons.menu),
            title: const Text('Menu principal'),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ContentPage()),
              );
            },
          ),
          */
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Agendar'),
            onTap: (() {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterService()),
              );
            }),
          ),
          ListTile(
            leading: const Icon(Icons.schedule_send),
            title: const Text('Minha agenda'),
            onTap: (() => null),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Meu perfil'),
            onTap: (() => null),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Contato'),
            onTap: (() => null),
          ),
          //const Divider(),
          /*ListTile(
            leading: const Icon(Icons.group),
            title: Text('Quem Somos'),
            onTap: (() => null),
          ),
          */
          ListTile(
            leading: const Icon(Icons.help),
            title: Text('Ajuda e Contato'),
            onTap: (() => null),
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: Text('Logout'),
            onTap: (() {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginApp()),
              );
            }),
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: (() { closeAppUsingExit();}),
          ),
          Divider(),
        ],
      ),
    );
  }
}