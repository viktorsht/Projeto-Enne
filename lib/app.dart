/*Importações do flutter*/
import 'package:enne_barbearia/views/content/login_app.dart';
import 'package:flutter/material.dart';

/*Importações do app*/
import 'views/theme/app_theme.dart';
import 'views/content/content_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Enne',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const LoginApp(),
    );
  }
}