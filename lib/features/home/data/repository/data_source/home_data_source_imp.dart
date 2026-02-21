import 'package:movie/core/error/failure.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/features/home/data/api/home_api.dart';
import 'package:movie/features/home/data/model/movie_dto.dart';
import 'package:movie/features/home/domain/entites/recommended_movies_entites.dart';
import 'package:movie/features/home/domain/repository/data_source/home_data_source.dart';

class HomeDataSourceImp implements HomeDataSource {
  final HomeApi _homeApi;

  HomeDataSourceImp(this._homeApi);

  @override
  Future<ApiResult<MoviesEntites>> getRecommendedMovies() async {
    final result = await _homeApi.getRecommendedMovies();

    return _handleApiResult(result);
  }

  @override
  Future<ApiResult<MoviesEntites>> getPopularMovies() async {
    final result = await _homeApi.getPopularMovies();

    return _handleApiResult(result);
  }

  @override
  Future<ApiResult<MoviesEntites>> getReleasesMovies() async {
    final result = await _homeApi.getReleasesMovies();

    return _handleApiResult(result);
  }

  /// ✅ دالة مساعدة لمعالجة نتيجة API وتحويل DTO إلى Entity
  ApiResult<MoviesEntites> _handleApiResult(ApiResult<MoviesDto> result) {
    switch (result) {
      case ApiSuccess<MoviesDto>():
        try {
          final moviesDto = result.data;
          final moviesEntity = moviesDto.toEntity();
          return ApiSuccess<MoviesEntites>(moviesEntity);
        } catch (e) {
          // في حالة حدوث خطأ أثناء التحويل
          return ApiError<MoviesEntites>(
            ServerFailure('Error converting data: ${e.toString()}'),
          );
        }

      case ApiError<MoviesDto>():
        // ✅ هنا result.failure وليس result.errorMessage
        // لأن ApiError يحتوي على failure وليس errorMessage
        return ApiError<MoviesEntites>(result.failure);
    }
  }
}

// إذا كنت تفضل استخدام when بدلاً من switch (اختياري)
extension ApiResultExtension<T> on ApiResult<T> {
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) error,
  }) {
    if (this is ApiSuccess<T>) {
      return success((this as ApiSuccess<T>).data);
    } else if (this is ApiError<T>) {
      return error((this as ApiError<T>).failure);
    }
    throw Exception('Unknown ApiResult type');
  }
}

// نسخة أخرى باستخدام when (إذا أضفت الـ extension أعلاه)
class HomeDataSourceImpWithWhen implements HomeDataSource {
  final HomeApi _homeApi;

  HomeDataSourceImpWithWhen(this._homeApi);

  @override
  Future<ApiResult<MoviesEntites>> getRecommendedMovies() async {
    final result = await _homeApi.getRecommendedMovies();

    return result.when(
      success: (dto) {
        try {
          return ApiSuccess<MoviesEntites>(dto.toEntity());
        } catch (e) {
          return ApiError<MoviesEntites>(
            ServerFailure('Error converting data: ${e.toString()}'),
          );
        }
      },
      error: (failure) => ApiError<MoviesEntites>(failure),
    );
  }

  @override
  Future<ApiResult<MoviesEntites>> getPopularMovies() async {
    final result = await _homeApi.getPopularMovies();

    return result.when(
      success: (dto) {
        try {
          return ApiSuccess<MoviesEntites>(dto.toEntity());
        } catch (e) {
          return ApiError<MoviesEntites>(
            ServerFailure('Error converting data: ${e.toString()}'),
          );
        }
      },
      error: (failure) => ApiError<MoviesEntites>(failure),
    );
  }

  @override
  Future<ApiResult<MoviesEntites>> getReleasesMovies() async {
    final result = await _homeApi.getReleasesMovies();

    return result.when(
      success: (dto) {
        try {
          return ApiSuccess<MoviesEntites>(dto.toEntity());
        } catch (e) {
          return ApiError<MoviesEntites>(
            ServerFailure('Error converting data: ${e.toString()}'),
          );
        }
      },
      error: (failure) => ApiError<MoviesEntites>(failure),
    );
  }
}