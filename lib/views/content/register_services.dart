import 'package:enne_barbearia/views/content/content_page.dart';
import 'package:enne_barbearia/views/content/register_date.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../ip_api.dart';
import '../../models/service.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterService extends StatefulWidget {
  const RegisterService({super.key});

  @override
  State<RegisterService> createState() => _RegisterServiceState();
}

class _RegisterServiceState extends State<RegisterService> {

  final dropValue = ValueNotifier('');
  List<dynamic> _dados = [];
  List<DropdownMenuItem<dynamic>> _dropdownItens = [];
  dynamic _valorSelecionado;
  SchedulingApiAppRequest serviceApi = SchedulingApiAppRequest();

  Future<void> _carregarDados() async {
    var url = Uri.parse('${DataApi.urlBaseApi}service');
    var response = await http.get(url);
    var dados = jsonDecode(response.body);
    setState(() {
      _dados = dados['data'];
      _dropdownItens = _dados.map((item) => DropdownMenuItem(
        value: item,
        child: Text(item['name']),
      )).toList();
    });
    print(_dados);
  }

  @override
  void initState() {
    super.initState();
    // Inicializa com o get na API
    _carregarDados();  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecione o serviço"), 
        centerTitle: true,
        backgroundColor: AppColors.secundaryColor,
        //automaticallyImplyLeading: false,
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
                    print(SchedulingApiAppRequest.idfkService);
                    // O valor do valor selecionado é salvo para poder fazer o agendamento
                  });
                  },
                ),
              );
            }
          ),
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.all(35)),
            ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secundaryColor,
              minimumSize: const Size(125, 40), 
            ),
            onPressed: () {
              //BOTÃO VOLTAR ...
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ContentPage()),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secundaryColor,
              minimumSize: const Size(100, 40), 
            ),
            onPressed: () {
              // CONTINUAR AGENDAMENTO ...
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const RegisterDate()),
              );
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