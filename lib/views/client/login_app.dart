import 'package:enne_barbearia/controllers/control_login.dart';
import 'package:enne_barbearia/views/theme/app_button.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:enne_barbearia/views/client/register_user.dart';
import 'package:enne_barbearia/views/client/home_page.dart';
import 'package:flutter/material.dart';
import '../../models/userActive.dart';
import '../admin/home_page_admin.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {

  LoginAppController loginAppController = LoginAppController();

  final _fromKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Form(
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
            const SizedBox(height: 35,),
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
            ElevatedButton(
              style: ButtonApp.themeButtonAppPrimary,
              onPressed: () async{
                if(_fromKey.currentState!.validate()){
                  int login = await loginAppController.submitLoginApi(_emailController.text,_senhaController.text);
                  String status = login.toString();
                  if(login == 200){
                    if(UserActiveApp.idUser == '1'){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePageAdmin()));
                    }
                    else{
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePageUser()));
                    }
                    
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("StatusCode: $status"),//Text('Email ou senha inválida! Por favor, insira dados válidos!'),
                        duration: const Duration(seconds: 5),
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
            const SizedBox(height: 35,),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(AppColors.backColor),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Register()),);
              },
              child: const Text('Não tenho conta',),
            ),
        ],
      ),
      )
    );
  }
}