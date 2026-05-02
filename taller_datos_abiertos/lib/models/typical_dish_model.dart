class TypicalDish {
  final int id;
  final String name;
  final String description;
  final String ingredients;
  final String? imageUrl;
  final int departmentId;
  final DepartmentInfo? department;

  TypicalDish({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    this.imageUrl,
    required this.departmentId,
    this.department,
  });

  factory TypicalDish.fromJson(Map<String, dynamic> json) {
    return TypicalDish(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      ingredients: json['ingredients'] ?? '',
      imageUrl: json['imageUrl'],
      departmentId: json['departmentId'] ?? 0,
      department: json['department'] != null
          ? DepartmentInfo.fromJson(json['department'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'ingredients': ingredients,
      'imageUrl': imageUrl,
      'departmentId': departmentId,
      'department': department?.toJson(),
    };
  }
}

class DepartmentInfo {
  final int id;
  final String name;
  final String description;
  final int cityCapitalId;
  final int municipalities;
  final int surface;
  final int population;
  final String phonePrefix;
  final int countryId;
  final String cityCapital;
  final CountryInfo? country;
  final List<String> cities;
  final int regionId;
  final RegionInfo? region;

  DepartmentInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.cityCapitalId,
    required this.municipalities,
    required this.surface,
    required this.population,
    required this.phonePrefix,
    required this.countryId,
    required this.cityCapital,
    this.country,
    required this.cities,
    required this.regionId,
    this.region,
  });

  factory DepartmentInfo.fromJson(Map<String, dynamic> json) {
    return DepartmentInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      cityCapitalId: json['cityCapitalId'] ?? 0,
      municipalities: json['municipalities'] ?? 0,
      surface: json['surface'] ?? 0,
      population: json['population'] ?? 0,
      phonePrefix: json['phonePrefix'] ?? '',
      countryId: json['countryId'] ?? 0,
      cityCapital: json['cityCapital'] ?? '',
      country: json['country'] != null
          ? CountryInfo.fromJson(json['country'])
          : null,
      cities: json['cities'] != null ? List<String>.from(json['cities']) : [],
      regionId: json['regionId'] ?? 0,
      region: json['region'] != null
          ? RegionInfo.fromJson(json['region'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'cityCapitalId': cityCapitalId,
      'municipalities': municipalities,
      'surface': surface,
      'population': population,
      'phonePrefix': phonePrefix,
      'countryId': countryId,
      'cityCapital': cityCapital,
      'country': country?.toJson(),
      'cities': cities,
      'regionId': regionId,
      'region': region?.toJson(),
    };
  }
}

class CountryInfo {
  final int id;
  final String name;
  final String description;
  final String stateCapital;
  final int surface;
  final int population;
  final List<String> languages;
  final String timeZone;
  final String currency;
  final String currencyCode;
  final String currencySymbol;
  final String isoCode;
  final String internetDomain;
  final String phonePrefix;
  final String radioPrefix;
  final String aircraftPrefix;
  final String subRegion;
  final String region;
  final List<String> borders;
  final List<String> flags;

  CountryInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.stateCapital,
    required this.surface,
    required this.population,
    required this.languages,
    required this.timeZone,
    required this.currency,
    required this.currencyCode,
    required this.currencySymbol,
    required this.isoCode,
    required this.internetDomain,
    required this.phonePrefix,
    required this.radioPrefix,
    required this.aircraftPrefix,
    required this.subRegion,
    required this.region,
    required this.borders,
    required this.flags,
  });

  factory CountryInfo.fromJson(Map<String, dynamic> json) {
    return CountryInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      stateCapital: json['stateCapital'] ?? '',
      surface: json['surface'] ?? 0,
      population: json['population'] ?? 0,
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : [],
      timeZone: json['timeZone'] ?? '',
      currency: json['currency'] ?? '',
      currencyCode: json['currencyCode'] ?? '',
      currencySymbol: json['currencySymbol'] ?? '',
      isoCode: json['isoCode'] ?? '',
      internetDomain: json['internetDomain'] ?? '',
      phonePrefix: json['phonePrefix'] ?? '',
      radioPrefix: json['radioPrefix'] ?? '',
      aircraftPrefix: json['aircraftPrefix'] ?? '',
      subRegion: json['subRegion'] ?? '',
      region: json['region'] ?? '',
      borders: json['borders'] != null
          ? List<String>.from(json['borders'])
          : [],
      flags: json['flags'] != null ? List<String>.from(json['flags']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'stateCapital': stateCapital,
      'surface': surface,
      'population': population,
      'languages': languages,
      'timeZone': timeZone,
      'currency': currency,
      'currencyCode': currencyCode,
      'currencySymbol': currencySymbol,
      'isoCode': isoCode,
      'internetDomain': internetDomain,
      'phonePrefix': phonePrefix,
      'radioPrefix': radioPrefix,
      'aircraftPrefix': aircraftPrefix,
      'subRegion': subRegion,
      'region': region,
      'borders': borders,
      'flags': flags,
    };
  }
}

class RegionInfo {
  final int id;
  final String name;
  final String description;
  final List<String> departments;

  RegionInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.departments,
  });

  factory RegionInfo.fromJson(Map<String, dynamic> json) {
    return RegionInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      departments: json['departments'] != null
          ? List<String>.from(json['departments'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'departments': departments,
    };
  }
}
