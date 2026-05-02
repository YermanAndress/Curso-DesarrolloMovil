class Presidente {
  final int id;
  final String? image;
  final String name;
  final String lastName;
  final DateTime startPeriodDate;
  final DateTime endPeriodDate;
  final String politicalParty;
  final String description;
  final int cityId;
  final String city;

  Presidente({
    required this.id,
    this.image,
    required this.name,
    required this.lastName,
    required this.startPeriodDate,
    required this.endPeriodDate,
    required this.politicalParty,
    required this.description,
    required this.cityId,
    required this.city,
  });

  factory Presidente.fromJson(Map<String, dynamic> json) {
    return Presidente(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      lastName: json['lastName'],
      startPeriodDate: DateTime.parse(json['startPeriodDate']),
      endPeriodDate: DateTime.parse(json['endPeriodDate']),
      politicalParty: json['politicalParty'],
      description: json['description'] ?? 'Sin descripción',
      cityId: json['cityId'],
      city: json['city'],
    );
  }
}
