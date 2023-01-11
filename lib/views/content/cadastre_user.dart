import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:enne_barbearia/views/content/register_user_completed.dart';
import 'package:flutter/material.dart';
//import 'content/app_button.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

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
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset('assets/logo.png'),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 35,
            ),
              TextFormField(
                keyboardType: TextInputType.name,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Nome",
                  // ignore: prefer_const_constructors
                  labelStyle: TextStyle(
                    color: AppColors.backColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    ),
                ),
                style: const TextStyle(fontSize: 20, color: AppColors.backColor),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                obscureText: true,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: "Telefone",
                  border: const OutlineInputBorder(),
                  // ignore: prefer_const_constructors
                  labelStyle: TextStyle(
                    color: AppColors.backColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    ),
                ),
                style: const TextStyle(fontSize: 20, color: AppColors.backColor),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: "Email",
                  border: const OutlineInputBorder(),
                  // ignore: prefer_const_constructors
                  labelStyle: TextStyle(
                    color: AppColors.backColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    ),
                ),
                style: const TextStyle(fontSize: 20, color: AppColors.backColor),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                obscureText: true,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: "Senha",
                  border: const OutlineInputBorder(),
                  // ignore: prefer_const_constructors
                  labelStyle: TextStyle(
                    color: AppColors.backColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    ),
                ),
                style: const TextStyle(fontSize: 20, color: AppColors.backColor),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                child: ElevatedButton(
                  style: theme_button_general,
                  onPressed: () {
                    /*Cadastro concluído com sucesso*/
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const RegUserCompleted()),
                    );
                  },
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.textColor
                      )
                    ),
                  ),
              ),
          ],
        ),
      ),
    );
  }
}