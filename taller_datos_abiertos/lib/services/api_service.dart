import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

import 'package:taller_datos_abiertos/models/departamento_model.dart';
import 'package:taller_datos_abiertos/models/presidente_model.dart';
import 'package:taller_datos_abiertos/models/tourist_attraction_model.dart';
import 'package:taller_datos_abiertos/models/typical_dish_model.dart';

class ApiService {
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Departamento>> getDepartments() async {
    try {
      final response = await client.get(
        Uri.parse('${AppConfig.apiBaseUrl}${AppConfig.departments}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Departamento.fromJson(json)).toList();
      } else {
        throw Exception(
          'Error al cargar departamentos: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<List<Presidente>> getPresidents() async {
    try {
      final response = await client.get(
        Uri.parse('${AppConfig.apiBaseUrl}${AppConfig.presidents}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Presidente.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar presidentes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<List<TouristAttraction>> getTouristAttractions() async {
    try {
      final response = await client.get(
        Uri.parse('${AppConfig.apiBaseUrl}${AppConfig.touristAttractions}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => TouristAttraction.fromJson(json)).toList();
      } else {
        throw Exception(
          'Error al cargar atractivos turísticos: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<List<TypicalDish>> getTypicalDishes() async {
    try {
      final response = await client.get(
        Uri.parse('${AppConfig.apiBaseUrl}${AppConfig.typicalDishes}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => TypicalDish.fromJson(json)).toList();
      } else {
        throw Exception(
          'Error al cargar platos típicos: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<TypicalDish> getTypicalDishDetail(int id) async {
    try {
      final response = await client.get(
        Uri.parse('${AppConfig.apiBaseUrl}${AppConfig.typicalDishes}/$id'),
      );

      if (response.statusCode == 200) {
        return TypicalDish.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error al cargar detalle del plato típico');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<Departamento> getDepartmentDetail(int id) async {
    try {
      final response = await client.get(
        Uri.parse('${AppConfig.apiBaseUrl}${AppConfig.departments}/$id'),
      );

      if (response.statusCode == 200) {
        return Departamento.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error al cargar detalle del departamento');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<Presidente> getPresidentDetail(int id) async {
    try {
      final response = await client.get(
        Uri.parse('${AppConfig.apiBaseUrl}${AppConfig.presidents}/$id'),
      );

      if (response.statusCode == 200) {
        return Presidente.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error al cargar detalle del presidente');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  void dispose() {
    client.close();
  }
}
