import 'package:movie/core/network/result.dart';
import 'package:movie/features/details/domain/entities/movie_details_entity.dart';
import 'package:movie/features/details/domain/entities/similar_movie_entity.dart';

abstract class DetailsDataSource {
  Future<ApiResult<MovieDetailsEntity>> getMovieDetails(int movieId);

  Future<ApiResult<List<SimilarMovieEntity>>> getSimilarMovies(int movieId);
}