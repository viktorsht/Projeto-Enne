import 'package:enne_barbearia/views/client/my_schedule.dart';
import 'package:enne_barbearia/views/client/help_screen.dart';
import 'package:enne_barbearia/views/client/login_app.dart';
import 'package:enne_barbearia/views/client/password_change.dart';
import 'package:enne_barbearia/views/client/profile_screen.dart';
import 'package:enne_barbearia/views/client/register_services.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
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
            accountName: Text('Olá, $name', style: const TextStyle(fontSize: 22),), 
            accountEmail: Text(email, style: const TextStyle(fontSize: 16)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(child: Image.asset('assets/logo.png', fit: BoxFit.cover)),
            ),
            decoration: const BoxDecoration(color: AppColors.red),
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Agendar'),
            onTap: (() {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const RegisterService()),
              );
            }),
          ),
          ListTile(
            leading: const Icon(Icons.schedule_send),
            title: const Text('Minha agenda'),
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MySchedule()),);
            }),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Meu perfil'),
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen()),);
            }),
          ),
          ListTile(
            leading: const Icon(Icons.password),
            title: const Text('Configurar senha'),
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
            title: const Text('Ajuda'),
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HelpScreen()),);
            }),
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Sair'),
            onTap: (() {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginApp()),
              );
            }),
          ),
        ],
      ),
    );
  }
}