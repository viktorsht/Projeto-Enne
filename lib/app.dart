/*Importações do flutter*/
import 'package:flutter/material.dart';

/*Importações do app*/
import 'core/theme/app_theme.dart';
import 'views/content/content_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Enne',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: ContentPage(),
    );
  }
}