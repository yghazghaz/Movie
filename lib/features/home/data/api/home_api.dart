import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie/core/error/failure.dart';
import 'package:movie/core/network/error_status_code_handle.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/core/utils/api_constants.dart';
import 'package:movie/features/home/data/model/movie_dto.dart';

class HomeApi {
  Future<ApiResult<MoviesDto>> getRecommendedMovies() async {
    try {
      Uri url = Uri.https(
        ApiConstants.apiBaseUrl,
        ApiConstants.apiPopularEndPoint,
        {"api_key": ApiConstants.apiKey},
      );

      var response = await http.get(url);

      // ✅ معالجة حالة النجاح
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var json = jsonDecode(response.body);
        MoviesDto moviesApiModel = MoviesDto.fromJson(json);
        return ApiSuccess<MoviesDto>(moviesApiModel);
      }
      // ✅ معالجة حالات الخطأ حسب Status Code
      else {
        final failure = ErrorStatusCodeHandle.handle(
          response.statusCode,
          response.body,
        );
        return ApiError<MoviesDto>(failure );
      }
    } catch (e) {
      // ✅ معالجة أخطاء الشبكة أو أي استثناءات أخرى
      return ApiError<MoviesDto>(
        ServerFailure('Network error: ${e.toString()}'),
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

      // ✅ معالجة حالة النجاح
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var json = jsonDecode(response.body);
        MoviesDto moviesApiModel = MoviesDto.fromJson(json);
        return ApiSuccess<MoviesDto>(moviesApiModel);
      }
      // ✅ معالجة حالات الخطأ حسب Status Code
      else {
        final failure = ErrorStatusCodeHandle.handle(
          response.statusCode,
          response.body,
        );
        return ApiError<MoviesDto>(failure );
      }
    } catch (e) {
      // ✅ معالجة أخطاء الشبكة أو أي استثناءات أخرى
      return ApiError<MoviesDto>(
        ServerFailure('Network error: ${e.toString()}') ,
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

      // ✅ معالجة حالة النجاح
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var json = jsonDecode(response.body);
        MoviesDto moviesApiModel = MoviesDto.fromJson(json);
        return ApiSuccess<MoviesDto>(moviesApiModel);
      }
      // ✅ معالجة حالات الخطأ حسب Status Code
      else {
        final failure = ErrorStatusCodeHandle.handle(
          response.statusCode,
          response.body,
        );
        return ApiError<MoviesDto>(failure );
      }
    } catch (e) {
      // ✅ معالجة أخطاء الشبكة أو أي استثناءات أخرى
      return ApiError<MoviesDto>(
        ServerFailure('Network error: ${e.toString()}') ,
      );
    }
  }
}

// ✅ دالة الـ Inject تبقى كما هي
HomeApi injectHomeApi() => HomeApi();
