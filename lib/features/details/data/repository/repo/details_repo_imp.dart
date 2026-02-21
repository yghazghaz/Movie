import 'package:injectable/injectable.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/features/details/domain/entities/movie_details_entity.dart';
import 'package:movie/features/details/domain/entities/similar_movie_entity.dart';
import 'package:movie/features/details/domain/repository/data_source/details_data_source.dart';
import 'package:movie/features/details/domain/repository/repo/base_details_repo.dart';
@LazySingleton(as:BaseDetailsRepository )

class DetailsRepoImpl implements BaseDetailsRepository {
  final DetailsDataSource detailsDataSource;

  DetailsRepoImpl(this.detailsDataSource);

  @override
  Future<ApiResult<MovieDetailsEntity>> getMovieDetails(int movieId) async {
    return await detailsDataSource.getMovieDetails(movieId);
  }

  @override
  Future<ApiResult<List<SimilarMovieEntity>>> getSimilarMovies(
    int movieId,
  ) async {
    return await detailsDataSource.getSimilarMovies(movieId);
  }
}
