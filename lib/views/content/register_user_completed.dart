import 'package:enne_barbearia/views/content/login_app.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegUserCompleted extends StatefulWidget {
  const RegUserCompleted({super.key});

  @override
  State<RegUserCompleted> createState() => RegUserCompletedState();
}

class RegUserCompletedState extends State<RegUserCompleted> {
  
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: CupertinoAlertDialog(
        // ignore: prefer_const_constructors
        title: Text(
          'Cadastro realizado com sucesso!!',
          style: const TextStyle(
            fontSize: 25, 
            color: AppColors.primaryColor)
          ),
        actions: [
          TextButton(
            //onPressed: () => Navigator.pop(context, 'OK'),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginApp()),
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