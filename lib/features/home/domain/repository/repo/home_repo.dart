import 'package:movie/core/network/result.dart';
import 'package:movie/features/home/domain/entities/recommended_movies_entities.dart';

abstract class HomeRepo {
  Future<ApiResult<MoviesEntities>> getRecommendedMovies();
  Future<ApiResult<MoviesEntities>> getPopularMovies();
  Future<ApiResult<MoviesEntities>> getReleasesMovies();
}
