

import 'package:movie/core/error/failure.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/features/details/domain/entities/movie_details_entity.dart';
import 'package:movie/features/details/domain/entities/similar_movie_entity.dart';
import 'package:movie/features/details/domain/repository/data_source/details_data_source.dart';
import 'package:movie/features/details/domain/repository/repo/base_details_repo.dart';

class DetailsRepoImpl implements BaseDetailsRepository {
  final DetailsDataSource detailsDataSource;

  DetailsRepoImpl(this.detailsDataSource);

  @override
  Future<ApiResult<MovieDetailsEntity>> getMovieDetails(int movieId) async {
    try {
      final result = await detailsDataSource.getMovieDetails(movieId);
      return ApiSuccess(result);
    } catch (error) {
      return ApiError(ServerFailure(error.toString()));
    }
  }

  @override
  Future<ApiResult<List<SimilarMovieEntity>>> getSimilarMovies(
    int movieId,
  ) async {
    try {
      final result = await detailsDataSource.getSimilarMovies(movieId);
      return ApiSuccess(result);
    } catch (error) {
      return ApiError(ServerFailure(error.toString()));
    }
  }
}
