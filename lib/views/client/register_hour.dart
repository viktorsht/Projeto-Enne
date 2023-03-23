import 'package:enne_barbearia/views/client/confirm_schedule.dart';
import 'package:enne_barbearia/views/client/register_date.dart';
import 'package:flutter/material.dart';
import '../../controllers/control_register_hour.dart';
import '../../models/service.dart';
import '../theme/app_button.dart';
import '../theme/app_colors.dart';

class RegisterHour extends StatefulWidget {
  @override
  _RegisterHourState createState() => _RegisterHourState();
}

class _RegisterHourState extends State<RegisterHour> {

  SchedulingApiAppRequest serviceApi = SchedulingApiAppRequest();
  RegisterHourController registerHourController = RegisterHourController();
  bool _isLoading = true;
  List<String> timeList = [];
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    registerHourController.getTimeActiveApi().then((list) {
      setState(() {
        timeList = list;
        _isLoading = false;
      });
    });
  }


  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      SchedulingApiAppRequest.hourStart = timeList[_selectedIndex];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteGrayColor,
      appBar: AppBar(
        title: const Text("Selecione a hora"),
        backgroundColor: AppColors.secundaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading 
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
            itemCount: timeList.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckboxListTile(
                tileColor: AppColors.whiteGrayColor,
                //tileColor: AppColors.secundaryColor,
                selectedTileColor: AppColors.secundaryColor,
                activeColor: AppColors.secundaryColor,
                title: Text(timeList[index], style: const TextStyle(color: AppColors.primaryColor),),
                value: _selectedIndex == index,
                onChanged: (value) => _onItemTap(index),
                );
              },
            ),
          ),
          Row(
            children: [
                const Padding(padding: EdgeInsets.all(35)),
                ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secundaryColor,
                  minimumSize: const Size(125, 40), 
                ),
                onPressed: () {
                  //BOTÃO VOLTAR ...
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const RegisterDate()),
                  );
                },
                child: const Text(
                  'Voltar',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.textColor
                    )
                  ),
                ),
                const SizedBox(width: 25,),
                ElevatedButton(
                style: ButtonApp.themeButtonSmall,
                onPressed: () async {
                  if(_selectedIndex == -1){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Insira um horário, por favor!'),
                        duration: Duration(seconds: 3),
                        backgroundColor: AppColors.secundaryColor,
                      ),
                    );
                  }
                  else{
                    //serviceApi.start = dataIngles;
                    int valida = await registerHourController.validaSchedule(serviceApi.contatenaData(SchedulingApiAppRequest.hourStart));
                    if (valida != 200){  
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AgendamentoCard(
                          data:SchedulingApiAppRequest.dataEmPtBr, 
                          servico: SchedulingApiAppRequest.namefkService, 
                          horario: SchedulingApiAppRequest.hourStart, 
                          preco: SchedulingApiAppRequest.precoService
                          )
                        ),
                      );
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Esse horário está ocupado! tente novamente'),
                        duration: Duration(seconds: 3),
                        backgroundColor: AppColors.secundaryColor,
                      ),
                    );
                    }
                    serviceApi.contatenaData(SchedulingApiAppRequest.hourStart);
                  }              
                },
                child: const Text(
                  'Prosseguir',
                  style: TextStyle(fontSize: 20,color: AppColors.textColor)
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

