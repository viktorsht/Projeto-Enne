import 'package:enne_barbearia/models/userActive.dart';
import 'package:enne_barbearia/views/admin/home_page_admin.dart';
import 'package:enne_barbearia/views/content/home_page.dart';
import 'package:enne_barbearia/views/content/register_scheduling.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AgendamentoCard extends StatelessWidget {
  final String data;
  final String servico;
  final String horario;
  final String preco;

  const AgendamentoCard({
    super.key, 
    required this.data, 
    required this.servico, 
    required this.horario, 
    required this.preco});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text("Confirme os dados"),
        backgroundColor: AppColors.secundaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Agendamento',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Data: $data',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 8),
                Text(
                  'Serviço: $servico',
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 8),
                Text(
                  'Horário: $horario',
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 8),
                Text(
                  'Preço: R\$ $preco',
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.all(35)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secundaryColor,
                        minimumSize: const Size(100, 40), 
                      ),
                      onPressed: () {
                        if(UserActiveApp.idUser == '1'){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePageAdmin()),);
                        }
                        else{
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePageUser()),);
                        }
                      },
                      child: const Text(
                        'Sair',
                        style: TextStyle(fontSize: 20,color: AppColors.textColor),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secundaryColor,
                        minimumSize: const Size(100, 40), 
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterScheduling()),);
                      },
                      child: const Text(
                        'Confirmar',
                        style: TextStyle(fontSize: 20,color: AppColors.textColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


