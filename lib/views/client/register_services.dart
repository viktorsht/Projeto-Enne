import 'package:enne_barbearia/views/client/home_page.dart';
import 'package:enne_barbearia/views/client/register_date.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../controllers/control_register_service.dart';
import '../../models/service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../theme/app_button.dart';

class RegisterService extends StatefulWidget {
  const RegisterService({super.key});

  @override
  State<RegisterService> createState() => _RegisterServiceState();
}

class _RegisterServiceState extends State<RegisterService> {

  final dropValue = ValueNotifier('');
  dynamic _valorSelecionado;
  SchedulingApiAppRequest serviceApi = SchedulingApiAppRequest();
  RegisterServiceController registerServiceController = RegisterServiceController();
  bool servicoSelecionado = false;
  List<DropdownMenuItem<dynamic>> _dropdownItens = [];

  List<dynamic> _dados = [];
  
  Future<void> carregarServices() async {
    var url = Uri.parse('${DataApi.urlBaseApi}service');
    var response = await http.get(url);
    var dados = jsonDecode(response.body);
    setState(() {
      _dados = dados['data'];
      _dropdownItens = _dados.map((item) => DropdownMenuItem(
        value: item,
        child: Text('${item['name']} - R\$ ${item['price']}'),
      )).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    carregarServices();  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecione o serviço"), 
        centerTitle: true,
        backgroundColor: AppColors.secundaryColor,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.primaryColor,
      body: ListView(
      children: [
        const SizedBox(height: 100),
        Center(
          child: ValueListenableBuilder(
            valueListenable: dropValue,
            builder: (BuildContext context,String  value, _){
              return SizedBox(
                width: 280,
                child:DropdownButtonFormField(
                  isExpanded: true,
                  hint: const Text('Selecione corte',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.primaryColor
                      )
                    ),
                  decoration:InputDecoration(
                    filled: true,
                    fillColor: AppColors.textColor,
                    //fillColor: ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    )
                  ),
                  value: _valorSelecionado,//(valorSelecionado.isEmpty) ? null : _valorSelecionado,
                  //onChanged: (escolha) => dropValue.value = escolha.toString(),
                  items: _dropdownItens,
                  onChanged: (valor) {
                  setState(() {
                    _valorSelecionado = valor;
                    SchedulingApiAppRequest.idfkService = _valorSelecionado['id'];
                    SchedulingApiAppRequest.namefkService = _valorSelecionado['name'];
                    SchedulingApiAppRequest.durationfkService = _valorSelecionado['duration'];
                    serviceApi.getPrecoServiceApi(SchedulingApiAppRequest.idfkService);
                    setState(() {
                      servicoSelecionado = true;
                    });
                  });
                  },
                ),
              );
            }
          ),
        ),
        Row(
          children: [
            const Padding(padding: EdgeInsets.all(35)),
            ElevatedButton(
            style: ButtonApp.themeButtonSmall,
            onPressed: () {
              //BOTÃO VOLTAR ...
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePageUser()),
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
            onPressed: () {
              // CONTINUAR AGENDAMENTO ...
              if(servicoSelecionado == true){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const RegisterDate()),);
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Insira um serviço, por favor!'),
                    duration: Duration(seconds: 3),
                    backgroundColor: AppColors.secundaryColor,
                  ),
                );
              }
            },
            child: const Text(
              'Prosseguir',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.textColor
                )
              ),
            ),
          ],
        )
        ]
      )
    );
  }
}