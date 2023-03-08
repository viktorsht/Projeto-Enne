import 'dart:io';
import 'package:enne_barbearia/app.dart';
import 'package:enne_barbearia/views/content/help_screen.dart';
import 'package:enne_barbearia/views/content/login_app.dart';
import 'package:enne_barbearia/views/content/password_change.dart';
import 'package:enne_barbearia/views/content/profile_screen.dart';
import 'package:enne_barbearia/views/content/register_services.dart';
import 'package:flutter/material.dart';
import '../../models/contato.dart';
import '../../models/userActive.dart';
import '../theme/app_colors.dart';
import 'contato_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  String id = "";
  String name = "";
  String email = "";

  void closeAppUsingExit() {
    exit(0);
  }

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores de texto com dados de exemplo
    id = UserActiveApp.idUser;
    name = UserActiveApp.nameUser;
    email = UserActiveApp.emailUser;
  }
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.whiteGrayColor,
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
            decoration: const BoxDecoration(color: AppColors.red),
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Agendar'),
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterService()),
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
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen()),);
            }),
          ),
          //const Divider(),
          ListTile(
            leading: const Icon(Icons.password),
            title: Text('Configurar senha'),
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TrocarSenhaScreen()),);
            }),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Contato'),
            onTap: (() async {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ContatoPage()),);
              
            }),
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: Text('Ajuda'),
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HelpScreen()),);
            }),
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: Text('Logout'),
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginApp()),
              );
            }),
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: (() {
                closeAppUsingExit();
              }
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}