import 'package:enne_barbearia/core/theme/app_button.dart';
import 'package:enne_barbearia/core/theme/app_colors.dart';
import 'package:enne_barbearia/core/theme/app_theme.dart';
import 'package:enne_barbearia/views/content/content_page.dart';
import 'package:flutter/material.dart';
//import 'content/app_button.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {

  final ButtonStyle theme_button_general = ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
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
                keyboardType: TextInputType.emailAddress,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "email/telefone",
                  // ignore: prefer_const_constructors
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    ),
                ),
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(
                height: 35,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                obscureText: true,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: "senha",
                  border: const OutlineInputBorder(),
                  // ignore: prefer_const_constructors
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    ),
                ),
                style: const TextStyle(fontSize: 20, color: Color.fromRGBO(136, 136, 136, 1)),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                child: ElevatedButton(
                  style: theme_button_general,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ContentPage()),
                    );
                  },
                  child: Text('Entrar',style: TextStyle(fontSize: 20)),
                  ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
              child:
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {},
                child: Text('Não tenho conta',),
              )
            ),
          ],
        ),
      ),
    );
  }
}