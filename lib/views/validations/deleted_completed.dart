
import 'package:enne_barbearia/views/client/home_page.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../models/userActive.dart';
import '../admin/home_page_admin.dart';
import '../theme/app_button.dart';

class TelaConfirmacaoDeleteSchedule extends StatelessWidget {
  const TelaConfirmacaoDeleteSchedule({super.key});

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
              'Remoção realizada com sucesso!',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonApp.themeButtonViewUpdate,
              onPressed: () {
                // Ação que será executada ao pressionar o botão
                if(UserActiveApp.idUser == '1'){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePageAdmin()));
                }
                else{
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePageUser()));
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