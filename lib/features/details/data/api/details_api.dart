
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movie/core/error/failure.dart';
import 'package:movie/core/network/error_status_code_handle.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/core/utils/api_constants.dart';
import 'package:movie/features/details/data/model/movie_details_dto.dart';

import '../model/similar_movie_dto.dart';

@injectable
class DetailsApi {
  Future<ApiResult<MovieDetailsDto>> getMovieDetails(int movieId) async {
    try {
      final uri = Uri.https(
        ApiConstants.apiBaseUrl,
        '${ApiConstants.apiMovieEndPoint}$movieId',
        {'api_key': ApiConstants.apiKey, 'language': 'en-US'},
      );

      final response = await http.get(uri);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        final dto = MovieDetailsDto.fromJson(json);
        return ApiSuccess(dto);
      } else {
        
        return ApiError<MovieDetailsDto>(ErrorStatusCodeHandle.handle(response.statusCode, json));
      }
    } catch (e) {
      if (e is SocketException) {
        return ApiError<MovieDetailsDto>(const NetworkFailure());
      }
      return ApiError<MovieDetailsDto>(
        const ServerFailure("Something went wrong. Please try again."),
      );
    }
  }

  Future<ApiResult<List<SimilarMovieDto>>> getSimilarMovies(int movieId) async {
    try {
      final uri = Uri.https(
        ApiConstants.apiBaseUrl,
        '${ApiConstants.apiMovieEndPoint}$movieId/similar',
        {'api_key': ApiConstants.apiKey},
      );

      final response = await http.get(uri);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);

        final List results = json['results'];

        final movies = results.map((e) => SimilarMovieDto.fromJson(e)).toList();

        return ApiSuccess(movies);
      } else {
        final failure = ErrorStatusCodeHandle.handle(
          response.statusCode,
          response.body,
        );
        return ApiError(failure);
      }
    } catch (e) {
      return ApiError(ServerFailure('Network error: ${e.toString()}'));
    }
  }
}


