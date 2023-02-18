import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:enne_barbearia/views/content/register_user_completed.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'content/app_button.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

Future<int> submitRegisterUserApi(var nome, var snome, var email, var cpf, var password, var level, var addr, var social) async {
  const myIp = '10.0.0.16';
  const String apiUrl = "http://$myIp/phpApi/public_html/api/registerUser/";
  String parametros = 'name=$nome&surname=$snome&email=$email&cpf=$cpf&password=$password&fk_level=$level&fk_address=$addr&fk_social=$social';
  try {
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded',},
      body: parametros,
    );
    if (response.statusCode == 200) {
      print("Cadastro de usuário bem sucedido: ${response.body}");
      return response.statusCode;
    } else {
      print("Cadastro de usuário não sucedido: ${response.statusCode}");
      return response.statusCode;
    }
  } catch (e) {
    print("Erro no Cadastro de usuário: $e");
  }
  return 0;
}

class _RegisterState extends State<Register> {

  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _senhaController = TextEditingController();
  final level = 3;
  final addr = 1;
  final social = 1;

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
                controller: _nomeController,
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
                keyboardType: TextInputType.name,
                controller: _sobrenomeController,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Sobrenome",
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
                controller: _emailController,
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
                controller: _cpfController,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: "CPF",
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
                controller: _senhaController,
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
                  onPressed: () async{
                    int register = await submitRegisterUserApi(
                      _nomeController, _sobrenomeController,_emailController,
                      _cpfController, _senhaController, level, addr, social);
                    /*Cadastro concluído com sucesso*/
                    if(register == 200){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegUserCompleted()));
                    }
                    else{
                      print('Código de registro = $register');
                    }
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