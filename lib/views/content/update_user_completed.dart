import 'package:enne_barbearia/views/content/home_page.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../models/userActive.dart';
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


class TelaConfirmacaoUpdate extends StatelessWidget {
  const TelaConfirmacaoUpdate({super.key});

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
            const SizedBox(height: 20),
            const Text(
              'Atualização de dados concluída',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secundaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                
              ),
              onPressed: () {
                // Ação que será executada ao pressionar o botão
                if(UserActiveApp.idUser == '1'){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePageAdmin()));
                }
                else{
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePageUser()));
                }
              },
              child: const Text('OK', style: TextStyle(
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
