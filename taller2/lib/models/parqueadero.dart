class Parqueadero {
  int id;
  String nombre;
  String nit;
  String direccion;
  String telefono;
  String logo;

  Parqueadero({
    required this.id,
    required this.nombre,
    required this.nit,
    required this.direccion,
    required this.telefono,
    required this.logo,
  });

  factory Parqueadero.fromJSON(Map<String, dynamic> json) {
    return Parqueadero(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      nit: json['nit'] as String,
      direccion: json['direccion'] as String,
      telefono: json['telefono'] as String,
      logo: json['logo'] as String,
    );
  }
}
