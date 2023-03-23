class AgendamentosCliente {
  String nome;
  String servico;
  String horario;
  String dia;
  String preco;
  String idAgendamento;

  AgendamentosCliente({
    required this.nome, 
    required this.servico, 
    required this.dia, 
    required this.horario, 
    required this.preco,
    required this.idAgendamento
    });
}