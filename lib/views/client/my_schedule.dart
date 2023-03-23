import 'package:enne_barbearia/models/schedule_client.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../controllers/control_chedule_user.dart';
import '../../models/userActive.dart';

bool carregandoDados = true;

class MySchedule extends StatefulWidget {
  @override
  _MyScheduleState createState() => _MyScheduleState();
}

class _MyScheduleState extends State<MySchedule> {
  List<AgendamentosCliente> appointments = [];
  CheduleUserController cheduleUserController = CheduleUserController();
  String name = "";
  @override
  void initState() {
    super.initState();
    name = UserActiveApp.nameUser;
    _loadAppointments();
    setState(() {
      carregandoDados = false;
    });
  }

  Future<void> _loadAppointments() async {
    try {
      final appointments = await CheduleUserController.getAgendamentos();
      setState(() {
        this.appointments = appointments.reversed.toList();
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
      appBar: AppBar(
        title: const Text('Meus Agendamentos'),
        centerTitle: true,
        backgroundColor: AppColors.secundaryColor,
        //automaticallyImplyLeading: false,
      ),
      body: carregandoDados 
            ? const Center(child: CircularProgressIndicator())
            : appointments.isEmpty
              ? Card(
                  color: AppColors.whiteGrayColor,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("$name, você não tem agendamentos!", 
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
                  itemBuilder: (BuildContext context, int index) {
                    final appointment = appointments[index];
                    return Card(
                      color: AppColors.whiteGrayColor,
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
                          ],
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secundaryColor,
                            minimumSize: const Size(100, 40), 
                          ),
                          child: const Text(
                            'Excluir',
                            style: TextStyle(fontSize: 18),
                            ),
                          onPressed: () async {
                            // Implementação da remoção do agendamento
                            int remover = await cheduleUserController.submitDeleteSchedule(appointment.idAgendamento);
                            if(remover == 200){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Agenda excluída com sucesso!"),//Text('Email ou senha inválida! Por favor, insira dados válidos!'),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: AppColors.secundaryColor,
                                ),
                              );
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MySchedule()),);
                            }
                          },
                        ),
                      ),
                    );
                  },
                )
    );
  }
}
