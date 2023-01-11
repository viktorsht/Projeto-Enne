import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:enne_barbearia/views/content/content_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChangeDone extends StatefulWidget {
  const ChangeDone({super.key});

  @override
  State<ChangeDone> createState() => _ChangeDoneState();
}

class _ChangeDoneState extends State<ChangeDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: CupertinoAlertDialog(
        // ignore: prefer_const_constructors
        title: Text(
          'Alteração concluída!!',
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