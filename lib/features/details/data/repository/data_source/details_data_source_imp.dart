import 'package:injectable/injectable.dart';
import 'package:movie/core/network/result.dart';
import 'package:movie/features/details/data/api/details_api.dart';
import 'package:movie/features/details/data/model/movie_details_dto.dart';
import 'package:movie/features/details/data/model/similar_movie_dto.dart';
import 'package:movie/features/details/domain/entities/movie_details_entity.dart';
import 'package:movie/features/details/domain/entities/similar_movie_entity.dart';
import 'package:movie/features/details/domain/repository/data_source/details_data_source.dart';

@LazySingleton(as: DetailsDataSource)
class DetailsDataSourceImpl implements DetailsDataSource {
  DetailsDataSourceImpl(this.detailsApi);

  final DetailsApi detailsApi;

  @override
  Future<ApiResult<MovieDetailsEntity>> getMovieDetails(
    int movieId,
  ) async {
    final result = await detailsApi.getMovieDetails(movieId);

    switch (result) {
      case ApiSuccess<MovieDetailsDto>():
        return ApiSuccess(result.data.toEntity());

      case ApiError<MovieDetailsDto>():
        return ApiError(result.failure);
    }
  }

  @override
  Future<ApiResult<List<SimilarMovieEntity>>> getSimilarMovies(
    int movieId,
  ) async {
    final result = await detailsApi.getSimilarMovies(movieId);

    switch (result) {
      case ApiSuccess<List<SimilarMovieDto>>():
        final entities =
            result.data.map((e) => e.toEntity()).toList();

        return ApiSuccess(entities);

      case ApiError<List<SimilarMovieDto>>():
        return ApiError(result.failure);
    }
  }
}