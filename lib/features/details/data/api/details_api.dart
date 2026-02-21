import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie/core/utils/api_constants.dart';


class DetailsApi {
  Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    final uri = Uri.https(
      ApiConstants.apiBaseUrl,
      '${ApiConstants.apiMovieEndPoint}$movieId',
      {'api_key': ApiConstants.apiKey, 'language': 'en-US'},
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<dynamic>> getSimilarMovies(int movieId) async {
    final uri = Uri.https(
      ApiConstants.apiBaseUrl,
      '${ApiConstants.apiMovieEndPoint}$movieId/similar',
      {'api_key': ApiConstants.apiKey},
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load similar movies');
    }
  }
}
