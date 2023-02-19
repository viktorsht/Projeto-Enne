import 'dart:io';

import 'package:enne_barbearia/views/content/register_services.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:enne_barbearia/views/content/content_page.dart';
import 'package:flutter/material.dart';


class NavBar extends StatelessWidget {
  const NavBar({super.key});


  void closeAppUsingExit() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //https://www.youtube.com/watch?v=SLR8U55FpFQ ASSISTIR PARA APRENDER
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            //backgroundColor: AppColors.primaryColor
            accountName: const Text('Olá'), 
            accountEmail: const Text('accountEmail'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(child: Image.asset('assets/logo.png', fit: BoxFit.cover)),
            ),
            decoration: const BoxDecoration(color: AppColors.secundaryColor),
          ),
          ListTile(
            leading: const Icon(Icons.menu),
            title: const Text('Menu principal'),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ContentPage()),
              );
            },
          ),
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
            title: Text('Ajuda'),
            onTap: (() => null),
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