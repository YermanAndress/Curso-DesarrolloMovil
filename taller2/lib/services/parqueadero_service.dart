import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/parqueadero.dart';

//! el parqueadero service es el encargado de hacer las peticiones a la api
class ParqueaderoService {
  // ! Se obtiene la url de la api desde el archivo .env
  String apiUrl = dotenv.env['PARQUEADERO_API_URL']!;

  // ! Método para obtener la lista de Parqueaderos
  // * se crea una istancia del modelo Parqueadero, se hace una petición http a la url de la api y se obtiene la respuesta
  // * si el estado de la respuesta es 200 se decodifica la respuesta y se obtiene la lista de resultados

  Future<List<Parqueadero>> getParqueaderos({int limit = 10}) async {
    final response = await http.get(
      Uri.parse('$apiUrl/establecimientos?limit=$limit'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // La respuesta viene en data['data']
      final List<dynamic> parqueaderosJson = data['data'] ?? [];

      // Mapeo directo sin peticiones adicionales
      return parqueaderosJson
          .map((item) => Parqueadero.fromJSON(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        'Error al obtener la lista de Parqueaderos: ${response.statusCode}',
      );
    }
  }

  // Método para obtener el detalle de un Parqueadero por ID
  Future<Parqueadero> getParqueaderoById(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/establecimientos/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Parqueadero.fromJSON(
        data,
      ); // se retorna el detalle del Parqueadero
    } else {
      throw Exception('Error al obtener el detalle del Parqueadero');
    }
  }
}
