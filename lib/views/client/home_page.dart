import 'package:enne_barbearia/models/schedule_client.dart';
import 'package:enne_barbearia/models/userActive.dart';
import 'package:enne_barbearia/views/client/validations/deleted_completed.dart';
import 'package:enne_barbearia/views/client/navigation.dart';
import 'package:enne_barbearia/views/client/register_services.dart';
import 'package:enne_barbearia/views/client/profile_screen.dart';
import 'package:enne_barbearia/views/theme/app_button.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../controllers/control_chedule_user.dart';

bool carregandoDados = true;

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser>{
  List<AgendamentosCliente> appointments = [];
  CheduleUserController cheduleUserController = CheduleUserController();
  String name = "";

  @override
  void initState() {
    super.initState();
    _carregaAgendamentos();
    setState(() {
      carregandoDados = false;
    });
    name = UserActiveApp.nameUser;
  }

  Future<void> _carregaAgendamentos() async {
    try {
      final appointments = await CheduleUserController.getAgendamentos();
      setState(() {
        this.appointments = appointments.toList();
      });
    } catch (e) {
      // Se a requisição falhar, você pode exibir uma mensagem de erro
      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      drawer: const Navigation(),
      appBar: AppBar(
        title: const Text('Enne'),
        centerTitle: true,
        //automaticallyImplyLeading: false,
        backgroundColor: AppColors.secundaryColor,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen()));
          },
        icon: const Icon(Icons.person)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox( width: 150, height: 160, child: Image.asset('assets/logo.png'),),
              const SizedBox(height: 30,),
              SizedBox(
                height: 225,
                child: carregandoDados 
                ? const Center(child: CircularProgressIndicator())
                : appointments.isEmpty
                  ? Card(
                      color: AppColors.whiteGrayColor,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("${UserActiveApp.nameUser}, você não tem agendamentos!", 
                          style: const TextStyle(
                            fontSize: 25, 
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: appointments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final appointment = appointments[index];
                        return Card(
                          color: AppColors.whiteGrayColor,
                          child: SizedBox(
                            width: 300,
                            child: ListTile(
                            title: Text('Nome: ${appointment.nome}', 
                              style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Serviço: ${appointment.servico}', 
                                    style: const TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Dia: ${appointment.dia}', 
                                    style: const TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Hora: ${appointment.horario}', 
                                    style: const TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Preço: R\$ ${appointment.preco}', 
                                    style: const TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.secundaryColor,
                                    minimumSize: const Size(80, 40), 
                                  ),
                                  child: const Text(
                                    'Excluir',
                                    style: TextStyle(fontSize: 18),
                                    ),
                                  onPressed: () async {
                                    // Implementação da remoção do agendamento
                                    int remover = await cheduleUserController.submitDeleteSchedule(appointment.idAgendamento);
                                    if(remover == 200){
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) => const TelaConfirmacaoDeleteSchedule()),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ),
              const SizedBox(height: 50,),
              ElevatedButton(
                style: ButtonApp.themeButtonAppSecundary,
                onPressed: () {
                //Cadastro concluído com sucesso
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const RegisterService()),);
                },
                child: const Text(
                  'Agendar agora!',
                  style: TextStyle(
                    fontSize: 25, color: AppColors.textColor
                  )
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
