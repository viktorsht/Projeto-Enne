import 'package:enne_barbearia/views/validations/update_user_completed.dart';
import 'package:enne_barbearia/views/theme/app_button.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../controllers/control_profile_screen.dart';
import '../../models/userActive.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _editMode = false;
  final idUser = UserActiveApp.idUser;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  ProfileScreenController profileScreenController = ProfileScreenController();
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
        title: const Text('Meu perfil'),
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
      style: ButtonApp.themeButtonAppPrimary,
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
      style: ButtonApp.themeButtonAppPrimary,
      child: const Text('Salvar', style: TextStyle(fontSize: 20),),
      onPressed: () async{
        // Salvar dados atualizados em um banco de dados ou em um servidor
        int register = await profileScreenController.submitUpdateUserApi(idUser,_nameController.text, _sobrenomeController.text, _emailController.text, _cpfController.text, _senhaController.text, 3,1,1);
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
