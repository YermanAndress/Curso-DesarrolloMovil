class Parqueadero {
  String nombre;
  String nit;
  String direccion;
  String telefono;
  String logo;

  Parqueadero({
    required this.nombre,
    required this.nit,
    required this.direccion,
    required this.telefono,
    required this.logo,
  });

  factory Parqueadero.fromJSON(Map<String, dynamic> json) {
    return Parqueadero(
      nombre: json['nombre'] as String,
      nit: json['nit'] as String,
      direccion: json['direccion'] as String,
      telefono: json['telefono'] as String,
      logo: json['logo'] as String,
    );
  }
}
