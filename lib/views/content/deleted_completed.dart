import 'package:enne_barbearia/core/theme/app_colors.dart';
import 'package:enne_barbearia/views/content/content_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeletedCompleted extends StatefulWidget {
  const DeletedCompleted({super.key});

  @override
  State<DeletedCompleted> createState() => _DeletedCompletedState();
}

class _DeletedCompletedState extends State<DeletedCompleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: CupertinoAlertDialog(
        // ignore: prefer_const_constructors
        title: Text(
          'Agenda excluída com sucesso!!',
          style: const TextStyle(
            fontSize: 25, 
            color: AppColors.primaryColor)
          ),
        actions: [
          TextButton(
            //onPressed: () => Navigator.pop(context, 'OK'),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ContentPage()),
            ),
            child: const Text(
              'Tela inicial',
              style: const TextStyle(
                fontSize: 20, 
                color: AppColors.primaryColor)
            ),
          ),
          //),
          
        ],
        content: Image.asset('assets/ok.png'),
      ),
    );
  }
}