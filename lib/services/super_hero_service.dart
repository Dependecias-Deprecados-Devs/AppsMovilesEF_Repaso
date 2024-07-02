import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:super_comics_app/models/super_hero.dart';

class SuperHeroService {
  final String baseUrl = "https://www.superheroapi.com/api.php/10157703717092094/search/";

  // Método para obtener superhéroes por nombre
  Future<List<SuperHero>> getSuperHeroesByName(String name) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl$name"));

      if (response.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['results'] != null) {
          final List maps = jsonResponse['results'];
          return maps.map((map) => SuperHero.fromJson(map)).toList();
        } else {
          // Maneja el caso donde 'results' es null
          return [];
        }
      } else {
        // Maneja errores HTTP
        throw const HttpException('Failed to load superheroes');
      }
    } catch (e) {
      // Maneja cualquier otra excepción
      print('Error fetching superheroes: $e');
      return [];
    }
  }
}
