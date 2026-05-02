class TouristAttraction {
  final int id;
  final String name;
  final String description;
  final List<String>? images;
  final String latitude;
  final String longitude;
  final String city;

  TouristAttraction({
    required this.id,
    required this.name,
    required this.description,
    this.images,
    required this.latitude,
    required this.longitude,
    required this.city,
  });

  factory TouristAttraction.fromJson(Map<String, dynamic> json) {
    return TouristAttraction(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      city: json['city'] ?? '',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }
}
