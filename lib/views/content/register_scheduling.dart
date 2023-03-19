import 'package:enne_barbearia/models/service.dart';
import 'package:enne_barbearia/views/content/home_page.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../api.dart';
import '../../models/userActive.dart';
import '../admin/home_page_admin.dart';

bool _isLoading = true;

void successAlertBox(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  Future<int> submitSchedulingAPI(var start, var end, var service, var client, var employee, var city) async {
    String apiUrl = "${DataApi.urlBaseApi}scheduling";
    String parametros = 'start=$start&end=$end&fk_service=$service&fk_client=$client&fk_employee=$employee&fk_city=$city';
    int retorno = 0;
    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded'},
        body: parametros,
      );
      if (response.statusCode == 200) {
        print("AGENDAMENTO bem sucedida: ${response.body}");
        //_isLoading = false;
        retorno = response.statusCode;
      } else {
        print("AGENDAMENTO não sucedida: ${response.statusCode}");
        retorno = response.statusCode;
      }
    } catch (e) {
      print("Erro na requisição: $e");
    }
    return retorno;
  }

class RegisterScheduling extends StatefulWidget {
  const RegisterScheduling({super.key});

  @override
  State<RegisterScheduling> createState() => _RegisterSchedulingState();
}


class _RegisterSchedulingState extends State<RegisterScheduling> {
   @override
  void initState() {
    super.initState();
    // Inicializa com o get na API
    SchedulingApiAppRequest req = SchedulingApiAppRequest();
    String hourEnd = req.somarHoras(SchedulingApiAppRequest.hourStart, SchedulingApiAppRequest.durationfkService);
    String endH = '${SchedulingApiAppRequest.dateStart} $hourEnd';
    SchedulingApiAppRequest.dateEnd = endH;
    SchedulingApiAppRequest.numeroDiaSemana = 0;
    //print("Data final: $endH");
    submitSchedulingAPI(SchedulingApiAppRequest.dateScheduling, SchedulingApiAppRequest.dateEnd, SchedulingApiAppRequest.idfkService, UserActiveApp.idUser, '2','1');  
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
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secundaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                
              ),
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