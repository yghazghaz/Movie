import 'package:movie/core/network/result.dart';
import 'package:movie/features/home/domain/entites/recommended_movies_entites.dart';

abstract class HomeRepo {
  Future<ApiResult<MoviesEntites>> getRecommendedMovies();
  Future<ApiResult<MoviesEntites>> getPopularMovies();
  Future<ApiResult<MoviesEntites>> getReleasesMovies();
}
