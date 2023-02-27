/*
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
              'Voltar e fazer login',
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
*/

import 'package:enne_barbearia/models/userActive.dart';
import 'package:enne_barbearia/views/content/login_app.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';

import '../admin/home_page_admin.dart';


void successAlertBox(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


class TelaConfirmacaoCadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/ok.png', // Substitua pelo nome do seu arquivo de GIF
              height: 200,
              width: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Cadastro concluído',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secundaryColor,
                padding: EdgeInsets.symmetric(horizontal: 30),
                
              ),
              onPressed: () {
                // Ação que será executada ao pressionar o botão
                if(UserActiveApp.idUser == '1'){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CrudScreenAdmin()));
                }
                else{
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginApp()));
                }
                //successAlertBox(context, 'Cadastro concluído!', '');
              },
              child: Text('OK', style: TextStyle(
                color: AppColors.textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
