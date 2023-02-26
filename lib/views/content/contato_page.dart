import 'dart:convert';

import 'package:enne_barbearia/models/contato.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


import '../../ip_api.dart';

class ContatoPage extends StatefulWidget {
  const ContatoPage({super.key});

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {

  String phoneNumber = "";
  String email = "";

  final ButtonStyle theme_button_general = ElevatedButton.styleFrom(
      backgroundColor: AppColors.secundaryColor,
      //minimumSize: Size(100, 50),
      //padding: EdgeInsets.symmetric(horizontal: 30),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
  );


  @override
  void initState() {
    super.initState();
    // Inicializa os controladores de texto com dados de exemplo
    email = ContatoApp.email;
    phoneNumber = ContatoApp.telefone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secundaryColor,
        title: const Text('Contato'),
      ),
      body: Center(
        //child: Card(
          //color: AppColors.primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fale Conosco!',
                  style: TextStyle(fontSize: 30, color: AppColors.textColor),
                ),
                const SizedBox(height: 16),
                Text(
                  'Telefone: $phoneNumber',
                  style: const TextStyle(fontSize: 20, color: AppColors.textColor),
                ),
                const SizedBox(height: 8),
                Text(
                  'E-mail: $email',
                  style: const TextStyle(fontSize: 20, color: AppColors.textColor),
                ),
                /*
                const SizedBox(height: 16),
                ElevatedButton(
                  style: theme_button_general,
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: phoneNumber));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Número copiado para a área de transferência'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Text('Copiar telefone'),
                ),*/
              ],
            ),
          ),
        ),
      //),
    ); 
  }
}
