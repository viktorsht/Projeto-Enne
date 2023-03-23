import 'package:enne_barbearia/views/theme/app_button.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:enne_barbearia/views/validations/register_user_completed.dart';
import 'package:flutter/material.dart';
import '../../controllers/contral_register_user.dart';
import '../../models/validaCPF.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  RegisterUserControlller registerUserControlller = RegisterUserControlller();

  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _senhaController = TextEditingController();
  final level = 3;
  final addr = 1;
  final social = 1;

  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset('assets/logo.png'),
            ),
            const SizedBox(height: 35,),
            const Center(
              child: Text(
                'Cadastro', 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 25, 
                  color: AppColors.textColor, 
                ),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: _nomeController,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Nome",
                labelStyle: const TextStyle(
                  color: AppColors.backColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              validator: (value) {
                if (value == null ||value.isEmpty) {
                  return 'Por favor, digite o seu nome';
                }
                return null;
              },
              style: const TextStyle(fontSize: 20, color: AppColors.backColor),
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: _sobrenomeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Sobrenome",
                labelStyle: TextStyle(
                  color: AppColors.backColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  ),
              ),
              validator: (value) {
                if (value == null ||value.isEmpty) {
                  return 'Por favor, digite o seu sobrenome';
                }
                return null;
              },
              style: const TextStyle(fontSize: 20, color: AppColors.backColor),
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border:  OutlineInputBorder(),
                labelStyle: TextStyle(
                  color: AppColors.backColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, digite o seu email';
                }
                if (!value.contains('@')) {
                  return 'Por favor, digite um email válido';
                }
                return null;
              },
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
              validator: (value) {
                if (ValidadorCpf.validar(value!) == false){
                  return 'Por favor, digite um CPF válido';
                }
                return null;
              },
              style: const TextStyle(fontSize: 20, color: AppColors.backColor),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _senhaController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Senha",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
                  color: AppColors.backColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, digite a sua senha';
                }
                if (value.length < 6) {
                  return 'A senha deve ter no mínimo 6 caracteres';
                }
                return null;
              },
              style: const TextStyle(fontSize: 20, color: AppColors.backColor),
            ),
            const SizedBox(height: 35,),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ButtonApp.themeButtonAppPrimary,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Voltar',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.textColor
                        )
                      ),
                    ),
                  const SizedBox(width: 40),
                  ElevatedButton(
                    style: ButtonApp.themeButtonAppPrimary,
                    onPressed: () async{
                        // Ação que será executada ao pressionar o botão "Cadastro 2"
                        if(_formKey.currentState!.validate()){
                        int register = await registerUserControlller.submitRegisterUserApi(
                          _nomeController.text, _sobrenomeController.text,_emailController.text,
                          _cpfController.text, _senhaController.text, level, addr, social);
                        if(register == 200){
                        /*Cadastro concluído com sucesso*/
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const TelaConfirmacaoCadastro()));
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Erro no cadastro, tente novamente!"),//Text('Email ou senha inválida! Por favor, insira dados válidos!'),
                              duration: Duration(seconds: 3),
                              backgroundColor: AppColors.secundaryColor,
                            ),
                          );
                        }
                      }
                    },
                      child: const Text('Cadastrar',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.textColor
                        )
                      ),
                    ), 
                  ],
              ),
          ],
        ),
      ),
    );
  }
}