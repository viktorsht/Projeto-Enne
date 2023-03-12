import 'dart:convert';

import 'package:enne_barbearia/models/userActive.dart';
import 'package:enne_barbearia/views/content/navigation.dart';
import 'package:enne_barbearia/views/content/register_services.dart';
import 'package:enne_barbearia/views/content/profile_screen.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../ip_api.dart';


class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage>{

  List<String> scheduleList = [];

  Future<List<String>> getSchedulingUser() async {
    String id = UserActiveApp.idUser;
    String url =  '${DataApi.urlBaseApi}scheduling/$id';
    //print(id);
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body)['data'];
      List<String> scheduleList = [];

      for (var data in responseData) {
        scheduleList.add(data['start']);
      }

      return scheduleList;
    } else {
      throw Exception('Requisição falida');
    }
  }

  @override
  void initState() {
    super.initState();
    //getSchedulingUser().then((list) {setState(() {scheduleList = list;});});
    getSchedulingUser();
    //print("Lista de Agendas: $scheduleList");
  }

  @override
  Widget build(BuildContext context) {

    final ButtonStyle themeButtonGeneral = ElevatedButton.styleFrom(
      backgroundColor: AppColors.secundaryColor,
      minimumSize: const Size(100, 50),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
  );

    return Scaffold(
      //bakccolor: AppColors.primaryColor,
      backgroundColor: AppColors.primaryColor,
      drawer: const Navigation(),
      appBar: AppBar(
        title: const Text('Enne'),
        centerTitle: true,
        backgroundColor: AppColors.secundaryColor,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen()));
          },
        icon: const Icon(Icons.person)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox( width: 150, height: 160, child: Image.asset('assets/logo.png'),),
              const SizedBox(height: 16,),
              ElevatedButton(
                style: themeButtonGeneral,
                onPressed: () {
                //Cadastro concluído com sucesso
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterService()),);
                },
                child: const Text(
                  'Agendar agora!',
                  style: TextStyle(
                    fontSize: 25, color: AppColors.textColor
                  )
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
