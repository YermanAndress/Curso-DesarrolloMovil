class Departamento {
  final int id;
  final String name;
  final String description;
  final List<String> departments;

  Departamento({
    required this.id,
    required this.name,
    required this.description,
    required this.departments,
  });

  factory Departamento.fromJson(Map<String, dynamic> json) {
    return Departamento(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      departments: List<String>.from(json['departments'] as List),
    );
  }
}
