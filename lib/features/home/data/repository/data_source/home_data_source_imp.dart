import 'package:injectable/injectable.dart';
import 'package:movie/core/error/failure.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/features/home/data/api/home_api.dart';
import 'package:movie/features/home/data/model/movie_dto.dart';
import 'package:movie/features/home/domain/entites/recommended_movies_entites.dart';
import 'package:movie/features/home/domain/repository/data_source/home_data_source.dart';

@LazySingleton(as: HomeDataSource)
class HomeDataSourceImp implements HomeDataSource {
  final HomeApi _homeApi;

  HomeDataSourceImp(this._homeApi);

  @override
  Future<ApiResult<MoviesEntites>> getRecommendedMovies() async {
    final result = await _homeApi.getRecommendedMovies();
    return _mapResult(result);
  }

  @override
  Future<ApiResult<MoviesEntites>> getPopularMovies() async {
    final result = await _homeApi.getPopularMovies();
    return _mapResult(result);
  }

  @override
  Future<ApiResult<MoviesEntites>> getReleasesMovies() async {
    final result = await _homeApi.getReleasesMovies();
    return _mapResult(result);
  }

  ApiResult<MoviesEntites> _mapResult(
    ApiResult<MoviesDto> result,
  ) {
    return result.when(
      success: (dto) {
        try {
          return ApiSuccess(dto.toEntity());
        } catch (e) {
          return ApiError(
            ServerFailure(
              'Error converting data: ${e.toString()}',
            ),
          );
        }
      },
      error: (failure) => ApiError(failure),
    );
  }
}