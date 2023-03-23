import 'package:enne_barbearia/models/service.dart';
import 'package:enne_barbearia/views/client/home_page.dart';
import 'package:enne_barbearia/views/theme/app_button.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../controllers/control_register_scheduling.dart';
import '../../models/userActive.dart';
import '../admin/home_page_admin.dart';


class RegisterScheduling extends StatefulWidget {
  const RegisterScheduling({super.key});

  @override
  State<RegisterScheduling> createState() => _RegisterSchedulingState();
}


class _RegisterSchedulingState extends State<RegisterScheduling> {

  RegisterScheduleController registerScheduleController = RegisterScheduleController();
  bool _isLoading = true;

   @override
  void initState() {
    super.initState();
    // Inicializa com o get na API
    SchedulingApiAppRequest req = SchedulingApiAppRequest();
    String hourEnd = req.somarHoras(SchedulingApiAppRequest.hourStart, SchedulingApiAppRequest.durationfkService);
    String endH = '${SchedulingApiAppRequest.dateStart} $hourEnd';
    SchedulingApiAppRequest.dateEnd = endH;
    SchedulingApiAppRequest.numeroDiaSemana = 0;
    registerScheduleController.submitSchedulingAPI(SchedulingApiAppRequest.dateScheduling, SchedulingApiAppRequest.dateEnd, SchedulingApiAppRequest.idfkService, UserActiveApp.idUser, '2','1');  
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child:  _isLoading 
            ? const Center(child: CircularProgressIndicator())
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/ok.png', // Substitua pelo nome do seu arquivo de GIF
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Agendamento concluído',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonApp.themeButtonSmall,
              onPressed: () {
                // Ação que será executada ao pressionar o botão
                if(UserActiveApp.idUser == '1'){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePageAdmin()));
                }
                else{
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePageUser()));
                }
                //successAlertBox(context, 'Cadastro concluído!', '');
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