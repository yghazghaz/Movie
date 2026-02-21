import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movie/core/error/failure.dart';
import 'package:movie/core/network/error_status_code_handle.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/core/utils/api_constants.dart';
import 'package:movie/features/home/data/model/movie_dto.dart';

@injectable
class HomeApi {
  Future<ApiResult<MoviesDto>> getRecommendedMovies() async {
    try {
      Uri url = Uri.https(
        ApiConstants.apiBaseUrl,
        ApiConstants.apiRecommendEndPoint,
        {"api_key": ApiConstants.apiKey},
      );

      var response = await http.get(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var json = jsonDecode(response.body);
        MoviesDto moviesApiModel = MoviesDto.fromJson(json);
        return ApiSuccess<MoviesDto>(moviesApiModel);
      } else {
        final failure = ErrorStatusCodeHandle.handle(
          response.statusCode,
          response.body,
        );
        return ApiError<MoviesDto>(failure);
      }
    } catch (e) {
      if (e is SocketException) {
        return ApiError<MoviesDto>(const NetworkFailure());
      }
      return ApiError<MoviesDto>(
        const ServerFailure("Something went wrong. Please try again."),
      );
    }
  }

  Future<ApiResult<MoviesDto>> getPopularMovies() async {
    try {
      Uri url = Uri.https(
        ApiConstants.apiBaseUrl,
        ApiConstants.apiPopularEndPoint,
        {"api_key": ApiConstants.apiKey},
      );

      var response = await http.get(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var json = jsonDecode(response.body);
        MoviesDto moviesApiModel = MoviesDto.fromJson(json);
        return ApiSuccess<MoviesDto>(moviesApiModel);
      } else {
        final failure = ErrorStatusCodeHandle.handle(
          response.statusCode,
          response.body,
        );
        return ApiError<MoviesDto>(failure);
      }
    } catch (e) {
      if (e is SocketException) {
        return ApiError<MoviesDto>(const NetworkFailure());
      }
      return ApiError<MoviesDto>(
        const ServerFailure("Something went wrong. Please try again."),
      );
    }
  }

  Future<ApiResult<MoviesDto>> getReleasesMovies() async {
    try {
      Uri url = Uri.https(
        ApiConstants.apiBaseUrl,
        ApiConstants.apiReleasesEndPoint,
        {"api_key": ApiConstants.apiKey},
      );

      var response = await http.get(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var json = jsonDecode(response.body);
        MoviesDto moviesApiModel = MoviesDto.fromJson(json);
        return ApiSuccess<MoviesDto>(moviesApiModel);
      } else {
        final failure = ErrorStatusCodeHandle.handle(
          response.statusCode,
          response.body,
        );
        return ApiError<MoviesDto>(failure);
      }
    } catch (e) {
      if (e is SocketException) {
        return ApiError<MoviesDto>(const NetworkFailure());
      }
      return ApiError<MoviesDto>(
        const ServerFailure("Something went wrong. Please try again."),
      );
    }
  }
}
