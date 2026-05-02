import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:taller_datos_abiertos/models/presidente_model.dart';

class ColombiaService {
  final String _baseUrl = dotenv.get('BASE_URL');

  Future<List<Presidente>> getPresidentes() async {
    final response = await http.get(Uri.parse('$_baseUrl/President'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Presidente.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar presidentes');
    }
  }
}
