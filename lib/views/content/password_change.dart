import 'dart:convert';
import 'package:enne_barbearia/models/userActive.dart';
import 'package:enne_barbearia/views/content/update_pass_complet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../ip_api.dart';
import '../theme/app_colors.dart';

class TrocarSenhaScreen extends StatefulWidget {
  const TrocarSenhaScreen({Key? key}) : super(key: key);

  @override
  _TrocarSenhaScreenState createState() => _TrocarSenhaScreenState();
}

class _TrocarSenhaScreenState extends State<TrocarSenhaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _senhaAtualController = TextEditingController();
  final _novaSenhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  final ButtonStyle theme_button_general = ElevatedButton.styleFrom(
      backgroundColor: AppColors.secundaryColor,
      minimumSize: Size(130, 50),
      padding: EdgeInsets.symmetric(horizontal: 30),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
  );

  String? _errorMessage;

  Future<int> trocarSenhaAPI(var id, var password) async {
  String myIp = IpApi.myIp;
  String apiUrl = "http://$myIp/phpApi/public_html/api/password";
  String parametros = 'id=$id&password=$password';
  try {
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded',},
      body: parametros,
    );
    if (response.statusCode == 200) {
      print("Atualização de senha bem sucedida: ${response.body}");
      return response.statusCode;
    } else {
      print("Atualização de senha não sucedida: ${response.statusCode}");
      return response.statusCode;
    }
  } catch (e) {
    print("Erro na atualização de senha: $e");
  }
  return 0;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secundaryColor,
        title: Text('Trocar senha'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(fontSize: 20, color: AppColors.textColor),
                  controller: _senhaAtualController,
                  
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha atual',
                    labelStyle: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w400,
                      //fontSize: 20,
                      ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'A senha atual é obrigatória.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  style: const TextStyle(fontSize: 20, color: AppColors.textColor),
                  controller: _novaSenhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Nova senha',
                    labelStyle: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w400,
                      //fontSize: 20,
                      ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'A nova senha é obrigatória.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  style: const TextStyle(fontSize: 20, color: AppColors.textColor),
                  controller: _confirmarSenhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirmar senha',
                    labelStyle: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w400,
                      //fontSize: 20,
                      ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'A confirmação da senha é obrigatória.';
                    } else if (value != _novaSenhaController.text) {
                      return 'A nova senha e a confirmação da senha não coincidem.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: theme_button_general,
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      int retorno = await trocarSenhaAPI(UserActiveApp.idUser,_confirmarSenhaController.text);
                      if(retorno == 200){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TelaConfirmacaoUpdatePass()));

                      }
                    }
                  },
                  child: Text('Trocar senha', style: TextStyle(fontSize: 20),),
                ),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: AppColors.secundaryColor,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
