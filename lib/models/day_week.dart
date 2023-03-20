
class DiaSemana {
  String id;
  String name;
  String status;

  DiaSemana({required this.id, required this.name, this.status = "0"});

  factory DiaSemana.fromJson(Map<String, dynamic> json) {
    return DiaSemana(
      id: json['id'],
      name: json['name'],
      status: json['status'] ?? "0",
    );
  }
}