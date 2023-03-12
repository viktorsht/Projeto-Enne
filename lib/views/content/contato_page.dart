import 'dart:convert';

import 'package:enne_barbearia/models/contato.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ContatoPage extends StatefulWidget {
  const ContatoPage({super.key});

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {

  String phoneNumber = "";
  String email = "";

  @override
  void initState() {
    super.initState();
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
              ],
            ),
          ),
        ),
      //),
    ); 
  }
}
