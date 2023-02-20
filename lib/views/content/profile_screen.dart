import 'package:enne_barbearia/models/userActive.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _editMode = false;
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.person, color: AppColors.textColor,),
              title: const Text('Nome', style: TextStyle(color: AppColors.textColor),),
              subtitle: _editMode ? TextFormField(
                controller: _nameController, style: const TextStyle(color: AppColors.textColor),) : Text(
                  _nameController.text, style: const TextStyle(color: AppColors.textColor),
                  ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: AppColors.textColor,),
              title: const Text('Sobrenome', style: TextStyle(color: AppColors.textColor),),
              subtitle: _editMode ? TextFormField(
                controller: _sobrenomeController, style: const TextStyle(color: AppColors.textColor),) : Text(
                  _sobrenomeController.text, style: TextStyle(color: AppColors.textColor),
                  ),
            ),
            ListTile(
              leading: const Icon(Icons.email, color: AppColors.textColor,),
              title: const Text('E-mail', style: TextStyle(color: AppColors.textColor),),
              subtitle: _editMode ? TextFormField(
                controller: _emailController, style: TextStyle(color: AppColors.textColor),) : Text(
                  _emailController.text, style: TextStyle(color: AppColors.textColor),),
            ),
            ListTile(
              leading: const Icon(Icons.credit_card , color: AppColors.textColor,),
              title: const Text('CPF', style: TextStyle(color: AppColors.textColor),),
              subtitle: _editMode ? TextFormField(
                controller: _cpfController, style: TextStyle(color: AppColors.textColor),) : Text(
                  _cpfController.text, style: TextStyle(color: AppColors.textColor),),
            ),
            /*
            ListTile(
              leading: const Icon(Icons.password, color: AppColors.textColor,),
              title: const Text('Senha', style: TextStyle(color: AppColors.textColor),),
              subtitle: _editMode ? TextFormField(
                obscureText: !_showPassword,
                controller: _senhaController, style: const TextStyle(color: AppColors.textColor),) 
                : const Text('********', style: const TextStyle(color: AppColors.textColor),),
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
    );
  }

  Widget _buildEditButton() {
    return ElevatedButton(
      style: theme_button_general,
      child: const Text('Editar perfil', style: TextStyle(fontSize: 20),),
      onPressed: () {
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
      onPressed: () {
        // Salvar dados atualizados em um banco de dados ou em um servidor
        setState(() {
          _editMode = false;
        });
      },
    );
  }
}
