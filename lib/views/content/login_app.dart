import 'dart:convert';

import 'package:enne_barbearia/views/theme/app_button.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:enne_barbearia/views/theme/app_theme.dart';
import 'package:enne_barbearia/views/content/cadastre_user.dart';
import 'package:enne_barbearia/views/content/content_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/loginModel.dart';

//import 'content/app_button.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

Future<int> submitLoginApi(var email, var password) async {
  const myIp = '10.0.0.16';
  const String apiUrl = "http://$myIp/phpApi/public_html/api/login";
  String parametros = 'email=$email&password=$password';
  var result = '';
  try {
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded',},
      body: parametros,
    );
    if (response.statusCode == 200) {
      print("Requisição bem sucedida: ${response.body}");
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

class _LoginAppState extends State<LoginApp> {

  final _fromKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  final ButtonStyle theme_button_general = ElevatedButton.styleFrom(
      backgroundColor: AppColors.secundaryColor,
      minimumSize: Size(130, 50),
      padding: EdgeInsets.symmetric(horizontal: 30),
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
              width: 300,
              height: 300,
              child: Image.asset('assets/logo.png'),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 35,
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
                style: TextStyle(fontSize: 20, color: AppColors.backColor),
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ContentPage()));
                      }
                      else{
                        setState(() {
                          _emailController.text = '';
                          _senhaController.text = '';
                        });
                      }
                    }
                    else{
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ContentPage()));
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Register()),
                    );
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