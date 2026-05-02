import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'https://api-colombia.com/api/v1';

  static const String departments = '/Department';
  static const String presidents = '/President';
  static const String touristAttractions = '/TouristicAttraction';
  static const String typicalDishes = '/TypicalDish';
}
