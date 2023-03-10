
import 'dart:convert';

import 'package:enne_barbearia/models/service.dart';
import 'package:enne_barbearia/models/userActive.dart';
import 'package:enne_barbearia/views/content/content_page.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../ip_api.dart';
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




// post do agendamento!

  Future<int> submitSchedulingAPI(var start, var end, var service, var client, var employee, var city) async {
  String myIp = IpApi.myIp;
  String apiUrl = "http://$myIp/phpApi/public_html/api/scheduling";
  String parametros = 'start=$start&end=$end&fk_service=$service&fk_client=$client&fk_employee=$employee&fk_city=$city';
  //UserActiveApp userActive = UserActiveApp();
  print('Iniciando agendamento na API');
  try {
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded'},
      body: parametros,
    );
    Map<String, dynamic> dadosApi = jsonDecode(response.body);
    //String json = jsonEncode(json_resposta);
    //Map<String, dynamic> dados = jsonDecode(json_resposta['data']);
    if (response.statusCode == 200) {
      print("Requisição bem sucedida: ${response.body}");
      _isLoading = false;
      //userActive.idUserActive(dadosApi['data']['id']);
      return response.statusCode;
    } else {
      print("Requisição não sucedida: ${response.statusCode}");
      return response.statusCode;
    }
  } catch (e) {
    print("Erro na requisição: $e");
  }
  return 0;
}

class RegisterScheduling extends StatefulWidget {
  const RegisterScheduling({super.key});

  @override
  State<RegisterScheduling> createState() => _RegisterSchedulingState();
}

bool _isLoading = true;

class _RegisterSchedulingState extends State<RegisterScheduling> {
   @override
  void initState() {
    super.initState();
    // Inicializa com o get na API
    SchedulingApiAppRequest req = SchedulingApiAppRequest();
    String hourEnd = req.somarHoras(SchedulingApiAppRequest.hourStart, SchedulingApiAppRequest.durationfkService);
    String endH = SchedulingApiAppRequest.dateStart + ' '+ hourEnd;
    SchedulingApiAppRequest.dateEnd = endH;
    print("Data final: $endH");
    submitSchedulingAPI(SchedulingApiAppRequest.dateScheduling, SchedulingApiAppRequest.dateEnd, SchedulingApiAppRequest.idfkService, UserActiveApp.idUser, '2','1');  
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CrudScreenAdmin()));
                }
                else{
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ContentPage()));
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

/*
class RegisterScheduling extends StatelessWidget {
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CrudScreenAdmin()));
                }
                else{
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ContentPage()));
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
*/