

import 'package:movie/features/details/domain/entities/movie_details_entity.dart';
import 'package:movie/features/details/domain/entities/similar_movie_entity.dart';

abstract class DetailsDataSource {
  Future<MovieDetailsEntity> getMovieDetails(int movieId);

  Future<List<SimilarMovieEntity>> getSimilarMovies(int movieId);
}
