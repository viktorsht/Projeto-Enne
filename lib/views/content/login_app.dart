import 'dart:convert';

import 'package:enne_barbearia/models/userActive.dart';
import 'package:enne_barbearia/views/content/my_schedule.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:enne_barbearia/views/content/cadastre_user.dart';
import 'package:enne_barbearia/views/content/content_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../ip_api.dart';
import '../../models/contato.dart';
import '../admin/home_page_admin.dart';


//import 'content/app_button.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}



class _LoginAppState extends State<LoginApp> {

  Future<int> submitLoginApi(var email, var password) async {
  String myIp = DataApi.myIp;
  String apiUrl = "${DataApi.urlBaseApi}login";
  print(apiUrl);
  String parametros = 'email=$email&password=$password';
  UserActiveApp userActive = UserActiveApp();
  ContatoApp contato = ContatoApp();
  print('Iniciando login na API');
  try {
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded',},
      body: parametros,
    );
  print('Obtendo informações de login na API');
    Map<String, dynamic> dadosApi = jsonDecode(response.body);
    //String json = jsonEncode(json_resposta);
    //Map<String, dynamic> dados = jsonDecode(json_resposta['data']);
    if (response.statusCode == 200) {
      print("Requisição bem sucedida: ${response.body}");
      userActive.idUserActive(dadosApi['data']['id']);
      contato.getContatoApp();
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

  final _fromKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  int time = 4;

  final ButtonStyle theme_button_general = ElevatedButton.styleFrom(
      backgroundColor: AppColors.secundaryColor,
      minimumSize: Size(130, 50),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
  );

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors


    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        child:Form(
          key: _fromKey,
          child: ListView(
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset('assets/logo.png'),
            ),
            const SizedBox(height: 35,),
            const Center(
              child: Text(
                'Login', 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 25, 
                  color: AppColors.textColor, 
                )
              ),
            ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "email",
                  // ignore: prefer_const_constructors
                  labelStyle: TextStyle(
                    color: AppColors.backColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    ),
                ),
                style: const TextStyle(fontSize: 20, color: AppColors.backColor),
                validator: (login){
                  if(login == null || login.isEmpty){
                    return 'login vazio!';
                  }else{
                  return null;
                  }
                }
              ),
              const SizedBox(
                height: 35,
              ),
              TextFormField(
                controller: _senhaController,
                keyboardType: TextInputType.number,
                obscureText: true,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: "senha",
                  border: const OutlineInputBorder(),
                  // ignore: prefer_const_constructors
                  labelStyle: TextStyle(
                    color: AppColors.backColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    ),
                ),
                style: const TextStyle(fontSize: 20, color: AppColors.backColor),
                validator: (senha){
                  if(senha == null || senha.isEmpty){
                    return 'senha vazia!';
                  }else{
                  return null;
                  }
                }
              ),

              const SizedBox( height: 35),
              
              Container(
                child: ElevatedButton(
                  style: theme_button_general,
                  onPressed: () async{
                    if(_fromKey.currentState!.validate()){
                      int login = await submitLoginApi(_emailController.text,_senhaController.text);
                      print('login = $login');
                      if(login == 200){
                        print(UserActiveApp.idUser);
                        if(UserActiveApp.idUser == '1'){
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CrudScreenAdmin()));
                        }
                        else{
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ContentPage()));
                        }
                        
                        
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Email ou senha inválida! Por favor, insira dados válidos!'),
                            duration: Duration(seconds: 4),
                            backgroundColor: AppColors.secundaryColor,
                          ),
                        );
                      }
                    }
                    else{
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ContentPage()));
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Email ou senha inválida! Por favor, insira dados válidos!'),
                        duration: Duration(seconds: 4),
                        backgroundColor: AppColors.secundaryColor,
                      ),
                    );
                    }
                  },
                  child: const Text('Entrar',style: TextStyle(fontSize: 20,color: AppColors.textColor)),
                  ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
              child:
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(AppColors.backColor),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Register()),);
                },
                child: const Text('Não tenho conta',),
              )
            ),
          ],
        ),
      ),
      )
    );
  }
}