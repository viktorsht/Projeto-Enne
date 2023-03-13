import 'package:enne_barbearia/models/userActive.dart';
import 'package:enne_barbearia/views/content/update_user_completed.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../ip_api.dart';

class ProfileScreenAdmin extends StatefulWidget {
  const ProfileScreenAdmin({super.key});

  @override
  _ProfileScreenAdminState createState() => _ProfileScreenAdminState();
}


Future<int> submitUpdateUserApi(var id, var nome, var snome, var email, var cpf, var password, var level, var addr, var social) async {
  String apiUrl = "${DataApi.urlBaseApi}updateUser/";
  String parametros = 'id=$id&name=$nome&surname=$snome&email=$email&cpf=$cpf&password=$password&fk_level=$level&fk_address=$addr&fk_social=$social';
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

class _ProfileScreenAdminState extends State<ProfileScreenAdmin> {
  bool _editMode = false;
  final idUser = UserActiveApp.idUser;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final ButtonStyle theme_button_general = ElevatedButton.styleFrom(
      backgroundColor: AppColors.secundaryColor,
      minimumSize: Size(100, 50),
      padding: EdgeInsets.symmetric(horizontal: 30),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
  );

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores de texto com dados de exemplo
    _nameController.text = UserActiveApp.nameUser;
    _sobrenomeController.text = UserActiveApp.sobrenameUser;
    _emailController.text = UserActiveApp.emailUser;
    _cpfController.text = UserActiveApp.cpfUser;
    _senhaController.text = UserActiveApp.senhaUser;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: AppColors.secundaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.person, color: AppColors.textColor,),
                title: const Text('Nome', style: TextStyle(fontSize: 20,color: AppColors.textColor),),
                subtitle: _editMode ? TextFormField(
                  controller: _nameController, style: const TextStyle(fontSize: 20,color: AppColors.textColor),) : Text(
                    _nameController.text, style: const TextStyle(fontSize: 20,color: AppColors.textColor),
                    ),
              ),
              ListTile(
                leading: const Icon(Icons.person, color: AppColors.textColor,),
                title: const Text('Sobrenome', style: TextStyle(fontSize: 20,color: AppColors.textColor),),
                subtitle: _editMode ? TextFormField(
                  controller: _sobrenomeController, style: const TextStyle(fontSize: 20,color: AppColors.textColor),) : Text(
                    _sobrenomeController.text, style: const TextStyle(fontSize: 20,color: AppColors.textColor),
                    ),
              ),
              ListTile(
                leading: const Icon(Icons.email, color: AppColors.textColor,),
                title: const Text('E-mail', style: TextStyle(fontSize: 20,color: AppColors.textColor),),
                subtitle: _editMode ? TextFormField(
                  controller: _emailController, style: const TextStyle(fontSize: 20,color: AppColors.textColor),) : Text(
                    _emailController.text, style: const TextStyle(fontSize: 20,color: AppColors.textColor),),
              ),
              ListTile(
                leading: const Icon(Icons.credit_card , color: AppColors.textColor,),
                title: const Text('CPF', style: TextStyle(fontSize: 20,color: AppColors.textColor),),
                subtitle: _editMode ? TextFormField(
                  controller: _cpfController, style: const TextStyle(fontSize: 20,color: AppColors.textColor),) : Text(
                    _cpfController.text, style: const TextStyle(fontSize: 20,color: AppColors.textColor),),
              ),
              /*
              ListTile(
                leading: const Icon(Icons.password, color: AppColors.textColor,),
                title: const Text('Senha', style: TextStyle(fontSize: 20,color: AppColors.textColor),),
                subtitle: _editMode ? TextFormField(
                  obscureText: !_showPassword,
                  controller: _senhaController, style: const TextStyle(fontSize: 20,color: AppColors.textColor),) 
                  : const Text('********', style: const TextStyle(fontSize: 20,color: AppColors.textColor),),
                trailing: IconButton(
                icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off, color: AppColors.textColor,),
                onPressed: () {setState(() {_showPassword = !_showPassword;});},
              ),
              ),
              */
              
              const SizedBox(height: 20),
              _editMode ? _buildSaveButton() : _buildEditButton(),
            ],
          ),
        ),
      )
    );
  }

  Widget _buildEditButton() {
    return ElevatedButton(
      style: theme_button_general,
      child: const Text('Editar perfil', style: TextStyle(fontSize: 20),),
      onPressed: (){
        setState(() {
          _editMode = true;
        });
      },
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      style: theme_button_general,
      child: const Text('Salvar', style: TextStyle(fontSize: 20),),
      onPressed: () async{
        // Salvar dados atualizados em um banco de dados ou em um servidor
        int register = await submitUpdateUserApi(idUser,_nameController.text, _sobrenomeController.text, _emailController.text, _cpfController.text, _senhaController.text, 3,1,1);
        if(register == 200){
        /*Cadastro concluído com sucesso*/
          UserActiveApp userActive = UserActiveApp();
          userActive.getUser();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TelaConfirmacaoUpdate()));
        }
        else{
          print('Código de registro = $register');
        }
        setState(() {
          _editMode = false;
        });
      },
    );
  }
}
