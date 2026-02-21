

import 'package:movie/features/details/data/api/details_api.dart';
import 'package:movie/features/details/data/model/movie_details_model.dart';
import 'package:movie/features/details/data/model/similar_movie_model.dart';
import 'package:movie/features/details/domain/repository/data_source/details_data_source.dart';

class DetailsDataSourceImpl implements DetailsDataSource {
  final DetailsApi detailsApi;

  DetailsDataSourceImpl({required this.detailsApi});

  @override
  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final jsonMap = await detailsApi.getMovieDetails(movieId);

    return MovieDetailsModel.fromJson(jsonMap);
  }

  @override
  Future<List<SimilarMovieModel>> getSimilarMovies(int movieId) async {
    final jsonList = await detailsApi.getSimilarMovies(movieId);

    return jsonList.map((e) => SimilarMovieModel.fromJson(e)).toList();
  }
}
