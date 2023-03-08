import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import '../../ip_api.dart';
import '../theme/app_colors.dart';

class RegisterHour extends StatefulWidget {
  const RegisterHour({super.key});

  @override
  State<RegisterHour> createState() => _RegisterHourState();
}

class _RegisterHourState extends State<RegisterHour> {

  List<String> items = [];
  List<int> hora = [];
  //List<dynamic> _dados = [];
  int _selectedIndex = -1;
  void _carregarDados() async {
      const myIp = IpApi.myIp;
      var url = Uri.parse('http://$myIp/phpApi/public_html/api/timeActive/1');
      //http://localhost/phpApi/public_html/api/timeActive/1
      var response = await http.get(url);

      try {
        if (response.statusCode == 200) {
          //print("Estou fazendo get do contato");
          var jsonResponse = jsonDecode(response.body);
          print('Dados do usuário: ${jsonResponse['data']}');
          //email = jsonResponse['data']['email'];
          //telefone = jsonResponse['data']['phone'];
          hora.add(jsonResponse['data']['time']);
        } else {
          print('Erro ao fazer a requisição. Código de status: ${response.statusCode}');
        }
        
      } catch (e) {
        print("Erro na requisição: $e");
      }

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
      //backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text("Selecione a hora", ),
        backgroundColor: AppColors.secundaryColor,
        centerTitle: true,
      ),
      body: Column(
  children: [
    Expanded(
      child: ListView(
        shrinkWrap: true,
        children: items.asMap().map((index, item) => MapEntry(index,
                GestureDetector(onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: ListTile(
                    title: Text(item),
                    leading: _selectedIndex == index
                        ? Icon(Icons.check)
                        : null,
                  ),
                )))
            .values
            .toList(),
      ),
    ),
    ElevatedButton(
      onPressed: _selectedIndex == -1
          ? null
          : () {
              // A opção selecionada está no índice "_selectedIndex"
            },
      child: Text('Selecionar'),
    ),
  ],
),

    );
  }
}